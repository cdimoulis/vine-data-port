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
      F1::Household.all.each do |household|
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

      # Build the Anonymous Cash user.
      cash = CIVICRM::Contact.new(
        first_name: "Anonymous",
        last_name: "Contribution",
        contact_type: 'Individual',
      )

      if !cash.valid? || !cash.save
        raise "Invalid Contact Model for Anonymous Cash\nCIVICRM::Contact: #{cash.errors.inspect}"
      end

      F1::ContributionReceipt.civicrm_create_all

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
      puts "\n\nids #{act_ids.count}\n\n"
      act_ids = act_ids.uniq
      puts "\n\nids2 #{act_ids.count}\n\n"
      ids.concat(act_ids)

      # Contribution Ids
      contrib_ids = CIVICRM::Contribution::where('receive_date >= ?', '2017-07-01').pluck('contact_id').uniq
      puts "\n\ncontrib ids #{contrib_ids.count}\n\n"

      ids = ids.concat(contrib_ids).uniq;
      puts "\n\nids #{ids.count}\n\n"

      contacts = CIVICRM::Contact.where('id in (?)',ids)
      indivs = contacts.where(contact_type: 'Individual')

      households = indivs.map do |i|
        types = CIVICRM::RelationshipType.where(contact_type_a: 'Individual', contact_type_b:'Household')
        rels = CIVICRM::Relationship.where(contact_id_a: i.id).where(relationship_type_id: types.pluck('id'))
        rels.pluck('contact_id_b')
      end

      households = households.flatten.uniq
      puts "\n\nhouseholds: #{households}\n\n"
      ids = ids.concat(households).uniq

      puts "\n\nFINAL IDS #{ids}\n#{ids.count}\n\n"

      # Remove unecessary records
      rem_contrib = CIVICRM::Contribution::where('receive_date < ?', '2017-07-01')
      puts "\n\nREMOVE CONTRIB: #{rem_contrib.count} out of #{CIVICRM::Contribution.count}\n\n"
      # rem_contrib.destroy_all
      rem_contacts = CIVICRM::Contact.where.not(id: ids)
      puts "\n\nREMOVE Contacts: #{rem_contacts.count} out of #{CIVICRM::Contact.count}\n\n"
      # rem_contacts.destroy_all

    end
  end
end
