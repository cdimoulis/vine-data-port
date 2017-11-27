class ALF::Communication < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :communication_id, :person, :household, :communication_type, :communication_value, :communication_listed, :communication_last_update, :communication_comment

  # Name to be sent in request to API
  def self.alf_name
    'info_communication'
  end

  # Primary id key for record
  def self.id_attribute
    'communication_id'
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

end
