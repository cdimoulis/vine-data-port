class ALF::Event < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :event_id, :event_category, :event_alt_text, :location, :date_time_text, :registration_description, :registration_link, :registration_start_date, :registration_end_date, :description_right, :description_left, :show_map, :show_slide, :show_schedule, :schedule_data, :show_masthead, :slide, :masthead, :slide_start_date, :slide_end_date, :street, :zip_code, :one_slide

  # Name to be sent in request to API
  def self.alf_name
    '6_event'
  end

  # Primary id key for record
  def self.id_attribute
    'event_id'
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
