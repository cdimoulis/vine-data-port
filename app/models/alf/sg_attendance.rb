class ALF::SgAttendance < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :sg_attendance_id, :meeting, :person, :status, :present

  # Name to be sent in request to API
  def self.alf_name
    'reporting_sg_attendance'
  end

  # Primary id key for record
  def self.id_attribute
    'sg_attendance_id'
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
