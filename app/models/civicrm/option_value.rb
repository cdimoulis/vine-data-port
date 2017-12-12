# +-----------------+------------------+------+-----+---------+----------------+
# | Field           | Type             | Null | Key | Default | Extra          |
# +-----------------+------------------+------+-----+---------+----------------+
# | id              | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | option_group_id | int(10) unsigned | NO   | MUL | NULL    |                |
# | label           | varchar(512)     | YES  |     | NULL    |                |
# | value           | varchar(512)     | NO   | MUL | NULL    |                |
# | name            | varchar(255)     | YES  | MUL | NULL    |                |
# | grouping        | varchar(255)     | YES  |     | NULL    |                |
# | filter          | int(10) unsigned | YES  |     | NULL    |                |
# | is_default      | tinyint(4)       | YES  |     | 0       |                |
# | weight          | int(10) unsigned | NO   |     | NULL    |                |
# | description     | text             | YES  |     | NULL    |                |
# | is_optgroup     | tinyint(4)       | YES  |     | 0       |                |
# | is_reserved     | tinyint(4)       | YES  |     | 0       |                |
# | is_active       | tinyint(4)       | YES  |     | 1       |                |
# | component_id    | int(10) unsigned | YES  | MUL | NULL    |                |
# | domain_id       | int(10) unsigned | YES  | MUL | NULL    |                |
# | visibility_id   | int(10) unsigned | YES  |     | NULL    |                |
# | icon            | varchar(255)     | YES  |     | NULL    |                |
# | color           | varchar(255)     | YES  |     | NULL    |                |
# +-----------------+------------------+------+-----+---------+----------------+
class CIVICRM::OptionValue < CIVICRM::Base

  belongs_to :option_group, class_name: CIVICRM::OptionGroup.name

end
