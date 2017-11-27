class ALF::Phone < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :phone_id, :person, :household, :phone_type, :phone_number,
    :phone_listed, :phone_last_update, :phone_created_date, :phone_comment

  # Name to be sent in request to API
  def self.alf_name
    "info_phone"
  end

  # Primary id key for record
  def self.id_attribute
    'phone_id'
  end

  # Belongs to associations
  # :association_name => {class: 'ALF::Classname',
  #                 through: 'attribute in model',
  #                 assoc_attribute: 'matching attribute in association'}
  def self.alf_belongs_to
    {
      :person => {class: "ALF::Person"},
      :household => {class: "ALF::Household"}
    }
  end

end
