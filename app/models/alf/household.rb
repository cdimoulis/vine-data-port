class ALF::Household < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :household_id, :household_name, :household_comment,
    :household_last_update, :household_created_date

  # Name to be sent in request to API
  def self.alf_name
    'info_household'
  end

  # Primary id key for record
  def self.id_attribute
    'household_id'
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
    household = contact_model()
    if !household.valid? || !household.save
      raise "Invalid Contact Model\nALF::Household: #{self.inspect}\nCIVICRM::Contact: #{contact.errors.inspect}"
    end

    prev_id = prev_id_model(contact)
    if !prev_id.valid? || !prev_id.save
      raise "Invalid ContactPrevId Model\nCIVICRM::Contact: #{contact.inspect}\nPrevId: #{prev_id.inspect}"
    end
    # More stuff if needed
  end

  def contact_model
    CIVICRM::Contact.new(
      :contact_type => "Household",
      :contact_sub_type => "Family",
      :sort_name => self.household_name,
      :display_name => self.household_name,
      :preferred_mail_format => 'Both', # Every record appears to have this
      :communication_style_id => nil,
      :email_greeting_id => nil,
      :email_greeting_custom => nil,
      :email_greeting_display => nil,
      :addressee_id => 1,
      :addressee_custom => nil,
      :addressee_display => nil,
      :household_name => self.household_name,
      :created_date => self.household_created_date,
      :modified_date => self.household_last_update
    )
  end

  # Pass in a created contact model to associate with this F1 model
  def prev_id_model(contact)
    return if contact.nil? or contact.id.nil? or !CIVICRM::Contact.exists?(contact.id)
    CIVICRM::ContactPrevId.new(
      contact_id: contact.id,
      alf_id: self.id
    )
  end

end
