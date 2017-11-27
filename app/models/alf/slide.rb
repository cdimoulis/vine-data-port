class ALF::Slide < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :slide_id, :slide_name, :slide_link, :slide_image, :slide_start_date, :slide_end_dat

  # Name to be sent in request to API
  def self.alf_name
    'info_slides'
  end

  # Primary id key for record
  def self.id_attribute
    'slide_id'
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
