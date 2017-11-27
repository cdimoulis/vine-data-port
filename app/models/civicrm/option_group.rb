# +-------------+------------------+------+-----+---------+----------------+
# | Field       | Type             | Null | Key | Default | Extra          |
# +-------------+------------------+------+-----+---------+----------------+
# | id          | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | name        | varchar(64)      | NO   | UNI | NULL    |                |
# | title       | varchar(255)     | YES  |     | NULL    |                |
# | description | varchar(255)     | YES  |     | NULL    |                |
# | is_reserved | tinyint(4)       | YES  |     | 1       |                |
# | is_active   | tinyint(4)       | YES  |     | NULL    |                |
# | is_locked   | tinyint(4)       | YES  |     | NULL    |                |
# | data_type   | varchar(128)     | YES  |     | NULL    |                |
# +-------------+------------------+------+-----+---------+----------------+
class CIVICRM::OptionGroup < CIVICRM::Base

  has_many :option_values, class_name: CIVICRM::OptionValue.name


end
