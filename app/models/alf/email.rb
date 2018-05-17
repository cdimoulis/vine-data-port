class ALF::Email < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :email_id, :person, :verification_hash, :email_address,
    :email_verified, :email_type, :email_listed, :email_last_update,
    :email_comment, :email_created_date

  # Name to be sent in request to API
  def self.alf_name
    "info_email"
  end

  # Primary id key for record
  def self.id_attribute
    'email_id'
  end

  def self.alf_belongs_to
    {
      :email_type => {class: "ALF::EmailType"},
    }
  end

  # Belongs to associations
  # :association_name => {class: 'ALF::Classname',
  #                 through: 'attribute in model',
  #                 assoc_attribute: 'matching attribute in association'}
  def self.alf_belongs_to
    {
      :person => {class: "ALF::Person"}
    }
  end

end
