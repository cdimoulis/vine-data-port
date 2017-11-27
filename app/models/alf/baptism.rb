class ALF::Baptism < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :id, :person_id, :baptism_date, :baptism_location, :baptism_comment, :baptism_created_date, :baptism_created_by, :baptism_updated_date, :baptism_updated_by

  # Name to be sent in request to API
  def self.alf_name
    'reporting_baptism'
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
