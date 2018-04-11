namespace :clear do
  task people: :environment do
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
      CIVICRM::FinancialType.destroy_all
      CIVICRM::Campaign.destroy_all
    end
  end
end
