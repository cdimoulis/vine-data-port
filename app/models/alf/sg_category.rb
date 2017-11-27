class ALF::SgCategory < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :group_category_id, :group_category_name, :group_category_descriptio

  # Name to be sent in request to API
  def self.alf_name
    'menu_sg_category'
  end

  # Primary id key for record
  def self.id_attribute
    'group_category_id'
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
