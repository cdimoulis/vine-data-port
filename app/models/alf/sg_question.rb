class ALF::SgQuestion < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :rsq_id, :rsq_group, :rsq_date, :q_1, :q_2, :q_3, :q_4, :q_5, :q_6, :q_6_1, :q_7, :q_7_1, :q_8, :q_9, :q_10

  # Name to be sent in request to API
  def self.alf_name
    'reporting_sg_questions'
  end

  # Primary id key for record
  def self.id_attribute
    'rsq_id'
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
