class ALF::EventTeachingBible < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :id, :teaching_id, :bible_start_id, :bible_end_id, :type

  # Name to be sent in request to API
  def self.alf_name
    'bridge_event_teaching_bible'
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
