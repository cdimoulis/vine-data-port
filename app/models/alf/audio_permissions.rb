class ALF::AudioPermission < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :id, :person_id, :schedule_id, :parent_id, :entered_by, :created_on, :updated_by, :updated_on

  # Name to be sent in request to API
  def self.alf_name
    'reporting_audio_permissions'
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
