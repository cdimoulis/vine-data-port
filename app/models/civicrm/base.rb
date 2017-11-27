class CIVICRM::Base < ActiveRecord::Base
  # -*- SkipSchemaAnnotations
  self.abstract_class = true
  establish_connection(:civicrm)

  def self.table_name
    self.name.underscore.gsub('/','_')
  end

end
