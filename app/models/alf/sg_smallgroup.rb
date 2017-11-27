class ALF::SgSmallgroup < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :smallgroup_id, :leader, :include_spouse, :dc, :smallgroup_start_date, :smallgroup_end_date, :smallgroup_active, :meets_at, :smallgroup_start_time, :smallgroup_end_time, :childcare, :allow_phone, :allow_email, :Description, :picture, :contact_phone, :contact_email, :meets_on

  # Name to be sent in request to API
  def self.alf_name
    'sg_smallgroup'
  end

  # Primary id key for record
  def self.id_attribute
    'smallgroup_id'
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
