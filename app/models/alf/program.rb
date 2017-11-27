class ALF::Program < ALF::Base
  # -*- SkipSchemaAnnotations

  attr_accessor :program_id, :program_name, :department, :program_logo, :description, :poc, :phone, :email, :overseer, :display

  # Name to be sent in request to API
  def self.alf_name
    "3_program"
  end

  # Primary id key for record
  def self.id_attribute
    'program_id'
  end

  # Belongs to associations
  # :association_name => {class: 'ALF::Classname',
  #                 through: 'attribute in model',
  #                 assoc_attribute: 'matching attribute in association'}
  def self.alf_belongs_to
    {
      :department => {class: 'ALF::Department'},
      :overseer => {class: "ALF::Person", through: 'overseer'},
      :poc =>{class: "ALF::Person", through: 'poc'},
      :email => {class: "ALF::Email"}#,
      # :display => {class: "ALF::DisplayAddress", through: 'display', assoc_attribute: 'display_id'}
    }
  end

end
