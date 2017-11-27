class ALF::StaffPosition < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :bridge_id, :group_id, :staff_id, :staff_position_id, :position_end_date, :position_start_date, :updated

  # Name to be sent in request to API
  def self.alf_name
    'bridge_staff_position'
  end

  # Primary id key for record
  def self.id_attribute
    'bridge_id'
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
