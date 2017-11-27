namespace :populate do
  # These must be done in a particular order to work so we
  # cannot automate it like with clear and info tasks
  task people: :environment do
    puts "\nStoring PEOPLE realm data...\n"
    F1::AttributeGroup.store_all_records
    puts "\nDone with AttributeGroup count: #{F1::AttributeGroup.count}\n"
    F1::Attribute.store_all_records
    puts "\nDone with Attribute count: #{F1::Attribute.count}\n"
    F1::Denomination.store_all_records
    puts "\nDone with Denomination count: #{F1::Denomination.count}\n"
    F1::Occupation.store_all_records
    puts "\nDone with Occupation count: #{F1::Occupation.count}\n"
    F1::School.store_all_records
    puts "\nDone with School count: #{F1::School.count}\n"
    F1::Status.store_all_records
    puts "\nDone with Status count: #{F1::Status.count}\n"
    F1::SubStatus.store_all_records
    puts "\nDone with SubStatus count: #{F1::SubStatus.count}\n"
    F1::AddressType.store_all_records
    puts "\nDone with AddressType count: #{F1::AddressType.count}\n"
    F1::HouseholdMemberType.store_all_records
    puts "\nDone with HouseholdMemberType count: #{F1::HouseholdMemberType.count}\n"
    F1::CommunicationType.store_all_records
    puts "\nDone with CommunicationType count: #{F1::CommunicationType.count}\n"
    F1::Requirement.store_all_records
    puts "\nDone with Requirement count: #{F1::Requirement.count}\n"
    F1::RequirementStatus.store_all_records
    puts "\nDone with RequirementStatus count: #{F1::RequirementStatus.count}\n"
    F1::BackgroundCheckStatus.store_all_records
    puts "\nDone with BackgroundCheckStatus count: #{F1::BackgroundCheckStatus.count}\n"
    F1::PeopleRequirement.store_all_records
    puts "\nDone with PeopleRequirement count: #{F1::PeopleRequirement.count}\n"
    # Campus has no records so not needed
    # F1::Campus.store_all_records
    # puts "\nDone with Campus count: #{F1::Campus.count}\n"

    F1::MaritalStatus.store_all_records
    puts "\nDone with MaritalStatus count: #{F1::MaritalStatus.count}\n"
    F1::Gender.store_all_records
    puts "\nDone with Gender count: #{F1::Gender.count}\n"
    F1::DateRangeType.store_all_records
    puts "\nDone with DateRangeType count: #{F1::DateRangeType.count}\n"

    puts "\nStarting Household. May take a while...\n"
    F1::Household.store_all_records nil, {recordsPerPage: 2000}
    puts "\nDone with Household count: #{F1::Household.count}\n"

    puts "\nStarting Person. May take a while...\n"
    F1::Person.store_all_records nil, {recordsPerPage: 2000}
    puts "\nDone with Person count: #{F1::Person.count}\n"

    puts "\nStarting Address. May take a while...\n"
    F1::Address.store_all_records
    puts "\nDone with Address count: #{F1::Address.count}\n"

    puts "\nStarting Communication. May take a while...\n"
    F1::Communication.store_all_records
    puts "\nDone with Communication count: #{F1::Communication.count}\n"

    puts "\nDone Storing PEOPLE realm data!\n"
  end

  task group: :environment do
    puts "\nStoring GROUP realm data...\n"
    F1::Category.store_all_records
    puts "\nDone with Category count: #{F1::Category.count}\n"
    F1::GroupType.store_all_records
    puts "\nDone with GroupType count: #{F1::GroupType.count}\n"
    F1::Timezone.store_all_records
    puts "\nDone with Timezone count: #{F1::Timezone.count}\n"
    F1::MemberType.store_all_records
    puts "\nDone with MemberType count: #{F1::MemberType.count}\n"
    F1::Group.store_all_records # Includes CategoriesGroup
    puts "\nDone with Group count: #{F1::Group.count}\n"
  end

  task event: :environment do
    F1::RecurrenceType.store_all_records
    puts "\nDone with RecurrenceType count: #{F1::RecurrenceType.count}\n"
    F1::Event.store_all_records
    puts "\nDone with Event count: #{F1::Event.count}\n"

    puts "\nStarting Location. May take a while...\n"
    F1::Location.store_all_records
    puts "\nDone with Location count: #{F1::Location.count}\n"

    puts "\nStarting Schedule. May take a while...\n"
    F1::Schedule.store_all_records
    puts "\nDone with Schedule count: #{F1::Schedule.count}\n"
  end

  task giving: :environment do
    F1::FundType.store_all_records
    puts "\nDone with FundType count: #{F1::FundType.count}\n"
    F1::Fund.store_all_records
    puts "\nDone with Fund count: #{F1::Fund.count}\n"
    F1::SubFund.store_all_records
    puts "\nDone with SubFund count: #{F1::SubFund.count}\n"
    F1::ContributionType.store_all_records
    puts "\nDone with ContributionType count: #{F1::ContributionType.count}\n"
    F1::ContributionSubType.store_all_records
    puts "\nDone with ContributionSubType count: #{F1::ContributionSubType.count}\n"
    F1::BatchType.store_all_records
    puts "\nDone with BatchType count: #{F1::BatchType.count}\n"
    F1::Batch.store_all_records # Includes BatchStatus
    puts "\nDone with Batch count: #{F1::Batch.count}\n"

    puts "\nStarting ContributionReceipt. May take a while...\n"
    F1::ContributionReceipt.store_all_records nil, {recordsPerPage: 3000}
    puts "\nDone with ContributionReceipt count: #{F1::ContributionReceipt.count}\n"
  end
end
