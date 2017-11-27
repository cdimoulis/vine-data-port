# +--------------+------------------+------+-----+---------+----------------+
# | Field        | Type             | Null | Key | Default | Extra          |
# +--------------+------------------+------+-----+---------+----------------+
# | id           | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | name         | varchar(64)      | YES  | UNI | NULL    |                |
# | display_name | varchar(64)      | YES  |     | NULL    |                |
# | vcard_name   | varchar(64)      | YES  |     | NULL    |                |
# | description  | varchar(255)     | YES  |     | NULL    |                |
# | is_reserved  | tinyint(4)       | YES  |     | NULL    |                |
# | is_active    | tinyint(4)       | YES  |     | NULL    |                |
# | is_default   | tinyint(4)       | YES  |     | NULL    |                |
# +--------------+------------------+------+-----+---------+----------------+


class CIVICRM::LocationType < CIVICRM::Base


end
