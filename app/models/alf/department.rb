class ALF::Department < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :department_id, :department_name, :church

  # Name to be sent in request to API
  def self.alf_name
    "2_department"
  end

  # Primary id key for record
  def self.id_attribute
    'department_id'
  end

  # Has many associations
  # :association_name => {class: 'ALF::Classname',
  #                 foreign_key: 'attribute with id in association'}
  def self.alf_has_many
    {
      :programs => {class: 'ALF::Email', foreign_key: 'department'},
    }
  end

end
