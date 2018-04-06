# +--------------------+------------------+------+-----+---------+----------------+
# | Field              | Type             | Null | Key | Default | Extra          |
# +--------------------+------------------+------+-----+---------+----------------+
# | id                 | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | contact_id         | int(10) unsigned | YES  | MUL | NULL    |                |
# | location_type_id   | int(10) unsigned | YES  | MUL | NULL    |                |
# | is_primary         | tinyint(4)       | YES  | MUL | 0       |                |
# | is_billing         | tinyint(4)       | YES  | MUL | 0       |                |
# | mobile_provider_id | int(10) unsigned | YES  | MUL | NULL    |                |
# | phone              | varchar(32)      | YES  | MUL | NULL    |                |
# | phone_ext          | varchar(16)      | YES  |     | NULL    |                |
# | phone_numeric      | varchar(32)      | YES  | MUL | NULL    |                |
# | phone_type_id      | int(10) unsigned | YES  |     | NULL    |                |
# +--------------------+------------------+------+-----+---------+----------------+

class CIVICRM::Phone < CIVICRM::Base

  belongs_to :contact, foreign_key: 'contact_id', class_name: CIVICRM::Contact
  belongs_to :location_type, foreign_key: 'location_type_id', class_name: CIVICRM::LocationType
  belongs_to :phone_type, -> { where option_group_id: CIVICRM::OptionGroup.where(name: 'phone_type').take.id }, foreign_key: 'phone_type_id', class_name: CIVICRM::OptionValue.name, primary_key: 'id'

end
