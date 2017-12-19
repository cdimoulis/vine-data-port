# +---------------------+------------------+------+-----+---------+----------------+
# | Field               | Type             | Null | Key | Default | Extra          |
# +---------------------+------------------+------+-----+---------+----------------+
# | id                  | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | domain_id           | int(10) unsigned | NO   | MUL | NULL    |                |
# | name                | varchar(64)      | YES  |     | NULL    |                |
# | label               | varchar(255)     | YES  |     | NULL    |                |
# | url                 | varchar(255)     | YES  |     | NULL    |                |
# | permission          | varchar(255)     | YES  |     | NULL    |                |
# | permission_operator | varchar(3)       | YES  |     | NULL    |                |
# | fullscreen_url      | varchar(255)     | YES  |     | NULL    |                |
# | is_active           | tinyint(4)       | YES  |     | 0       |                |
# | is_reserved         | tinyint(4)       | YES  |     | 0       |                |
# | cache_minutes       | int(10) unsigned | NO   |     | 60      |                |
# +---------------------+------------------+------+-----+---------+----------------+

class CIVICRM::Dashboard < CIVICRM::Base



end
