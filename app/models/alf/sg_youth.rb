class ALF::SgYouth < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :youthgroup_id, :leader, :include_spouse, :youthgroup_start_date, :youthgroup_end_date, :youthgroup_active, :meets_at, :youthgroup_start_time, :youthgroup_end_time, :allow_phone, :allow_email, :picture, :grade, :contact_phone, :contact_email, :meets_on

  # Name to be sent in request to API
  def self.alf_name
    'sg_youth'
  end

  # Primary id key for record
  def self.id_attribute
    'youthgroup_id'
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
