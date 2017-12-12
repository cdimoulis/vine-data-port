namespace :build do
  namespace :civicrm do
    # Build the civicrm Database from F1
    task f1: :environment do
      # Remove all contacts, prev_ids and relationships
      CIVICRM::Contact.destroy_all
      CIVICRM::ContactPrevId.destroy_all
      CIVICRM::Relationship.destroy_all

      # Create people contacts
      F1::Person.all.each do |person|
        person.civicrm_models
      end

      # Create Household contacts
      F1::Household.all.each do |household|
        household.civicrm_models
      end

      # Create Addresses
      CIVICRM::Address.destroy_all
      F1::Address.all.each do |address|
        address.civicrm_models
      end

      # Create emails and phones
      CIVICRM::Email.destroy_all
      CIVICRM::Phone.destroy_all
      F1::Communication.all.each do |comm|
        comm.civicrm_models
      end
    end
  end
end
