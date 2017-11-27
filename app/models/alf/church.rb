class ALF::Church < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :church_info_id, :id, :church_address1, :church_address2, :church_zip, :church_phone, :church_fax, :church_url, :church_logo

  # Name to be sent in request to API
  def self.alf_name
    'info_church'
  end

  # Primary id key for record
  def self.id_attribute
    'church_info_id'
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
