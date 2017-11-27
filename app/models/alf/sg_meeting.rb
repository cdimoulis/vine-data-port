class ALF::SgMeeting < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :sg_meeting_id, :smallgroup, :date, :meeting_type, :week_number, :updated

  # Name to be sent in request to API
  def self.alf_name
    'reporting_sg_meeting'
  end

  # Primary id key for record
  def self.id_attribute
    'sg_meeting_id'
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
