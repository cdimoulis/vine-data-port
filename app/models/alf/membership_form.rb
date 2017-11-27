class ALF::MembershipForm < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :id, :membership_person_id, :membership_signed_by, :membership_form_date, :membership_form_url, :membership_comment, :membership_created_by, :membership_created_date, :membership_updated_by, :membership_updated_date

  # Name to be sent in request to API
  def self.alf_name
    'reporting_membership_form'
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
