class ALF::MembershipStatus < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :memnbership_status_id, :membership_status_name

  # Name to be sent in request to API
  def self.alf_name
    'menu_membership_status'
  end

  # Primary id key for record
  def self.id_attribute
    'memnbership_status_id'
  end

  # Belongs to associations
  # :association_name => {class: 'ALF::Classname',
  #                 through: 'attribute in model',
  #                 assoc_attribute: 'matching attribute in association'}
  def self.alf_belongs_to
    {

    }
  end

  # Has many associations
  # :association_name => {class: 'ALF::Classname',
  #                 foreign_key: 'attribute with id in association'}
  def self.alf_has_many
    {

    }
  end


  ####
  # CIVICRM model mapping
  ####

  # The mapping to civicrm
  def civicrm_models
    option_value_model
  end

  def option_value_model
    CIVICRM::OptionValue.create_new_membership_status membership_status_name
  end

  # Create all missing models
  def self.civicrm_create_all
    group = CIVICRM::OptionGroup.where(name: 'membership_status_20121112161808').take
    start = CIVICRM::OptionValue.where(option_group_id: group.id).count
    records = self.get_all_records

    records.each do |r|
      r.civicrm_models
    end
    done = CIVICRM::OptionValue.where(option_group_id: group.id).count
    puts "Created: #{done - start} CIVICRM::OptionValue records From ALF::MembershipStatus records\n\n"
  end

end
