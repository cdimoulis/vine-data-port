namespace :build do
  namespace :civicrm do
    # Build the civicrm Database from F1
    task f1: :environment do

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
  end
end
