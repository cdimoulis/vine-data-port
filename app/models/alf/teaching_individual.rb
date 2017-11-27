class ALF::TeachingIndividual < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :teaching_id, :series_id, :teaching_date, :teaching_title, :pastor, :audio_file, :notes_file

  # Name to be sent in request to API
  def self.alf_name
    'teaching_individual'
  end

  # Primary id key for record
  def self.id_attribute
    'teaching_id'
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
