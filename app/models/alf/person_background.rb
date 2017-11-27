class ALF::PersonBackground < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :id, :person, :employer, :job_title, :occupation, :occupation_description, :current_or_last_school_name

  # Name to be sent in request to API
  def self.alf_name
    'info_person_background'
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
