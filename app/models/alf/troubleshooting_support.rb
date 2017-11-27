class ALF::TroubleshootingSupport < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :support_id, :support_page, :support_type, :support_comment, :support_priority

  # Name to be sent in request to API
  def self.alf_name
    'troubleshooting_support'
  end

  # Primary id key for record
  def self.id_attribute
    'support_id'
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
