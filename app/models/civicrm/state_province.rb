# +-------------------+------------------+------+-----+---------+----------------+
# | Field             | Type             | Null | Key | Default | Extra          |
# +-------------------+------------------+------+-----+---------+----------------+
# | id                | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | name              | varchar(64)      | YES  | MUL | NULL    |                |
# | abbreviation      | varchar(4)       | YES  |     | NULL    |                |
# | country_id        | int(10) unsigned | NO   | MUL | NULL    |                |
# +-------------------+------------------+------+-----+---------+----------------+


class CIVICRM::StateProvince < CIVICRM::Base



end
