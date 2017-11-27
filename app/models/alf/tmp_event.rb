class ALF::TmpEvent < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :id, :start_date, :location, :registration_link, :registration_start, :registration_end, :description_right, :description_left, :show_map, :show_slide, :slide, :masthead, :slide_start, :slide_end, :street, :city, :state, :zip_code

  # Name to be sent in request to API
  def self.alf_name
    'tmp_event'
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
