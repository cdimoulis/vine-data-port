class ALF::UserLogin < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :userlogin_id, :username, :password, :active, :registration_date,
    :userlogin_last_update, :email_verified, :verification_code, :usergroup_id,
    :redirect, :expires, :updated_by

  # Name to be sent in request to API
  def self.alf_name
    'access_userlogin'
  end

  # Primary id key for record
  def self.id_attribute
    'userlogin_id'
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
