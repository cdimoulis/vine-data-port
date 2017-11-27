class ALF::Grade < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :grade_id, :grade_name, :grade_number, :grade_dc, :gender, :sg_category

  # Name to be sent in request to API
  def self.alf_name
    'menu_sg_youth'
  end

  # Primary id key for record
  def self.id_attribute
    'grade_id'
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
