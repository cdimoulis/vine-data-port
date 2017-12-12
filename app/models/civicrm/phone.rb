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


end
