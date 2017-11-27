# +-------------------------+------------------+------+-----+---------+----------------+
# | Field                   | Type             | Null | Key | Default | Extra          |
# +-------------------------+------------------+------+-----+---------+----------------+
# | id                      | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | name                    | varchar(64)      | YES  | MUL | NULL    |                |
# | iso_code                | char(2)          | YES  |     | NULL    |                |
# | country_code            | varchar(4)       | YES  |     | NULL    |                |
# | address_format_id       | int(10) unsigned | YES  | MUL | NULL    |                |
# | idd_prefix              | varchar(4)       | YES  |     | NULL    |                |
# | ndd_prefix              | varchar(4)       | YES  |     | NULL    |                |
# | region_id               | int(10) unsigned | NO   | MUL | NULL    |                |
# | is_province_abbreviated | tinyint(4)       | YES  |     | 0       |                |
# +-------------------------+------------------+------+-----+---------+----------------+


class CIVICRM::Country < CIVICRM::Base



end
