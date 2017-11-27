class ALF::EventCategory < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :event_category_id, :event_category_name, :calendar, :category_color, :text_color, :borderColor, :head_count_adjustment

  # Name to be sent in request to API
  def self.alf_name
    '5_event_category'
  end

  # Primary id key for record
  def self.id_attribute
    'event_category_id'
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
