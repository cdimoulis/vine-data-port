class ALF::TeachingSeries < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :series_id, :series_title, :series_description, :series_graphic, :series_start_date, :banner_position

  # Name to be sent in request to API
  def self.alf_name
    'teaching_series'
  end

  # Primary id key for record
  def self.id_attribute
    'series_id'
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
