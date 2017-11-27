# Load the civicrm database
DB_CIVICRM = YAML::load(ERB.new(File.read(Rails.root.join("config","database_civicrm.yml"))).result)[Rails.env]
