namespace :clear do
  task f1: :environment do
    models = F1.constants.select {|c| F1.const_get(c).is_a? Class}
    models.each do |model|
      name = "F1::#{model}"
      cls = name.constantize
      if !cls.abstract_class
        puts "Clearing #{name} count: #{cls.count}\n"
        cls.destroy_all
        puts "Done clearing #{name} count: #{cls.count}\n"
      end
    end
  end


  namespace :civicrm do
    task all: :environment do
      Rake::Task['clear:civicrm:contributions'].invoke
      Rake::Task['clear:civicrm:contact'].invoke
    end

    task contact: :environment do
      # Serving stuff
      CIVICRM::MembershipType.destroy_all
      CIVICRM::Membership.destroy_all

      # Membership Status
      CIVICRM::ValueAssimilation.destroy_all
      # Membership Status menu
      group = CIVICRM::OptionGroup.where(name: 'membership_status_20121112161808').take
      CIVICRM::OptionValue.where(option_group_id: group.id).destroy_all

      # Remove all contacts, prev_ids and relationships
      # Also contact personal info (phone, address, email)
      CIVICRM::Contact.remove_all
      CIVICRM::VineContactPrevId.destroy_all
      CIVICRM::Relationship.destroy_all
      CIVICRM::Address.destroy_all
      CIVICRM::Email.destroy_all
      CIVICRM::Phone.destroy_all

    end

    task contributions: :environment do
      CIVICRM::Contribution.destroy_all
      CIVICRM::Campaign.destroy_all
    end
  end

  namespace :alf do
    task all: :environment do
      Rake::Task['clear:alf:contact'].invoke
    end

    task contact: :environment do
      prevs = CIVICRM::VineContactPrevId.where.not(alf_id: nil)

      prevs.each do |prev|
        contact = CIVICRM::Contact.find(prev.contact_id)

        value_assimilation_model = CIVICRM::ValueAssimilation.where(entity_id: contact.id).take
        value_assimilation_model.destroy if !value_assimilation_model.nil?

        emails = CIVICRM::Email.where(contact_id: contact.id)
        emails.destroy_all

        phones = CIVICRM::Phone.where(contact_id: contact.id)
        phones.destroy_all

        addresses = CIVICRM::Address.where(contact_id: contact.id)
        addresses.destroy_all

        relsa = CIVICRM::Relationship.where(contact_id_a: contact.id)
        relsa.destroy_all
        relsb = CIVICRM::Relationship.where(contact_id_b: contact.id)
        relsb.destroy_all

        contact.destroy
      end

      prevs.destroy_all
    end
  end
end
