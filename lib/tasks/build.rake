namespace :build do
  namespace :civicrm do
    # Build the civicrm contacts from F1 people and households
    task f1_people: :environment do

      # Create membership status menus
      # Yes start with ALF in this case
      ALF::MembershipStatus.civicrm_create_all
      F1::Status.civicrm_create_all

      # Create people contacts
      F1::Person.all.each do |person|
        person.civicrm_models
      end
      indiv_count = CIVICRM::Contact.count
      puts "CIVICRM created #{indiv_count} Individual Contacts\n"

      # Create Household contacts
      head_type = F1::HouseholdMemberType.where(name: 'Head').take
      spouse_type = F1::HouseholdMemberType.where(name: 'Spouse').take
      F1::Household.all.each do |household|
        f1_person = F1::Person.where(household_id: household.id, household_member_type_id: head_type.id).take
        f1_person = F1::Person.where(household_id: household.id, household_member_type_id: spouse_type.id).take if f1_person.nil?
        f1_person = F1::Person.where(household_id: household.id).first if f1_person.nil?
        if f1_person.present?
          household.household_name = "#{f1_person.first_name} #{f1_person.last_name}"
        end
        household.civicrm_models
      end
      house_count = CIVICRM::Contact.count - indiv_count
      puts "CIVICRM created #{house_count} Household Contacts and #{CIVICRM::Relationship.count} Contact Relationships\n"

      # Address types are put into CIVICRM::LocationType
      # However we can't just delete that table since CIVICRM has some records
      # already in the table
      F1::AddressType.civicrm_create_all

      # CIVICRM::OptionValues from F1::CommunicationType
      F1::CommunicationType.civicrm_models

      # Create Addresses
      F1::Address.all.each do |address|
        address.civicrm_models
      end
      puts "CIVICRM created #{CIVICRM::Address.count} Addresses\n"

      # Create emails and phones
      F1::Communication.all.each do |comm|
        comm.civicrm_models
      end
      puts "CIVICRM created #{CIVICRM::Email.count} Emails and #{CIVICRM::Phone.count} Phones\n"
    end

    # build the CIVICRM contributions from f1
    task f1_contributions: :environment do

      F1::Fund.civicrm_create_all
      CIVICRM::Campaign.build_models

      cash = CIVICRM::Contact.where(first_name: 'Anonymous', last_name:'Contribution', contact_type: 'Individual').take
      if cash.nil?
        # Build the Anonymous Cash user.
        cash = CIVICRM::Contact.new(
          first_name: "Anonymous",
          last_name: "Contribution",
          contact_type: 'Individual',
        )

        if !cash.valid? || !cash.save
          raise "Invalid Contact Model for Anonymous Cash\nCIVICRM::Contact: #{cash.errors.inspect}"
        end
      end

      F1::ContributionReceipt.civicrm_create_all

    end

    # task alf_people: :environment do
    #   # ALF IDs
    #   text = File.read('db/reporting_sg_attendance.csv')
    #   alf_ids = text.gsub("\"","").split("\n").map{ |t| t.to_i }
    #   member_ids = []
    #   # puts "\n\n#{alf_ids.inspect}\n\n"
    #   alf_ids.each do |id|
    #     # Create the person and household contact models
    #     alf_person = ALF::Person.findId(id)
    #     alf_person.civicrm_models
    #     alf_household = ALF::Household.findId(alf_person.household)
    #     alf_household.civicrm_models if !alf_household.nil?
    #
    #     # Get the members also and add them to the
    #     if !alf_household.nil?
    #       members = ALF::Person.where('household', alf_household.household_id)
    #       m_ids = members.map{ |m| m.person_id }
    #       # Don't include ids we already have
    #       member_ids.concat(m_ids - alf_ids)
    #     end
    #
    #     # Relate the person to the household
    #     alf_person.householdRelation
    #   end
    #
    #   member_ids = member_ids.uniq
    #
    #   # Create members of households
    #   member_ids.each do |id|
    #     # Create the person and household contact models
    #     alf_person = ALF::Person.findId(id)
    #     alf_person.civicrm_models
    #
    #     # Relate the person to the household
    #     alf_person.householdRelation
    #   end
    #
    #   puts "\n\nFinished Adding #{alf_ids.count + member_ids.count} people from ALF\n\n"
    # end

    task alf_people: :environment do
      curr_count = CIVICRM::Contact.count
      # ALF IDs
      text = File.read('db/sg_attendance_households.csv')
      household_ids = text.gsub("\"","").split("\n").map{ |t| t.to_i }

      puts "\nStarting households and members\n"

      household_ids.each do |hid|
        members = ALF::Person.where('household', hid)
        members.each do |member|
          member.civicrm_models
        end

        person = members.select { |m| m.household_position == 1}[0]
        person = members.select { |m| m.household_position == 2}[0] if person.nil?
        person = members[0] if person.nil?

        household = ALF::Household.new(
          household_id: hid,
          household_name: "#{person.first_name} #{person.last_name}",
        )

        household.civicrm_models
        household.householdRelations(members)
      end

      puts "\nDone with Households and members.\nAdded #{CIVICRM::Contact.count - curr_count} Contacts\n"
      puts "\nStarting people w/o households\n"
      curr_count = CIVICRM::Contact.count

      # People with no household
      # text = File.read('db/sg_attendance_person_no_house.csv')
      # person_ids = text.gsub("\"","").split("\n").map{ |t| t.to_i }
      #
      # person_ids.each do |pid|
      #   person = ALF::Person.findId(pid)
      #   person.civicrm_models
      # end

      puts "\nDone with people w/o households.\nAdded #{CIVICRM::Contact.count - curr_count} Contacts\n"

    end

    task date_limit: :environment do
      require 'csv'
      u = CIVICRM::Contact.where(first_name: 'Anonymous', last_name: 'Contribution').take
      ids = [u.id]
      indiv_type = CIVICRM::ContactType.where(name: 'Individual').take

      # Activity IDs
      text = File.read('db/event_attendance.csv')
      csv = CSV.parse(text, :headers=>true)
      act_ids = csv.map do |x|
        prev = CIVICRM::VineContactPrevId.where(f1_id: x['Individual ID'], contact_type_id: indiv_type.id).take
        if prev.present?
          prev.contact_id
        end
      end
      act_ids = act_ids.uniq
      ids.concat(act_ids)

      # Contribution Ids
      contrib_ids = CIVICRM::Contribution::where('receive_date >= ?', '2017-07-01').pluck('contact_id').uniq

      ids = ids.concat(contrib_ids).uniq;

      contacts = CIVICRM::Contact.where('id in (?)',ids)
      indivs = contacts.where(contact_type: 'Individual')

      # Get the households of the individuals
      households = indivs.map do |i|
        types = CIVICRM::RelationshipType.where(contact_type_a: 'Individual', contact_type_b:'Household')
        rels = CIVICRM::Relationship.where(contact_id_a: i.id).where(relationship_type_id: types.pluck('id'))
        rels.pluck('contact_id_b')
      end

      households = households.flatten.uniq
      ids = ids.concat(households).uniq

      # Get the members of the households that may not have been
      members = households.map do |h|
        types = CIVICRM::RelationshipType.where(contact_type_a: 'Individual', contact_type_b:'Household')
        rels = CIVICRM::Relationship.where(contact_id_b: h).where(relationship_type_id: types.pluck('id'))
        rels.pluck('contact_id_a')
      end

      members = members.flatten.uniq
      ids = ids.concat(members).uniq

      # Remove unecessary records
      rem_contrib = CIVICRM::Contribution::where('receive_date < ?', '2017-07-01')
      puts "\n\nREMOVE CONTRIB: #{rem_contrib.count} out of #{CIVICRM::Contribution.count}\n\n"
      rem_contrib.destroy_all
      puts "#{CIVICRM::Contribution.count} Contributions Remaining\n\n"


      CIVICRM::VineContactPrevId.where.not(contact_id: ids).destroy_all

      CIVICRM::Relationship.where.not(contact_id_a: ids).destroy_all
      CIVICRM::Relationship.where.not(contact_id_b: ids).destroy_all

      CIVICRM::Address.where.not(contact_id: ids).destroy_all
      CIVICRM::Phone.where.not(contact_id: ids).destroy_all
      CIVICRM::Email.where.not(contact_id: ids).destroy_all


      rem_contacts = CIVICRM::Contact.where.not(id: ids, display_name: 'Vine Church')
      puts "\n\nREMOVE Contacts: #{rem_contacts.count} out of #{CIVICRM::Contact.count}"
      rem_contacts.destroy_all
      puts "#{CIVICRM::Contact.count} Contacts Remaining\n\n"

    end
  end
end
