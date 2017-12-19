# +-----------------------+------------------+------+-----+---------+----------------+
# | Field                 | Type             | Null | Key | Default | Extra          |
# +-----------------------+------------------+------+-----+---------+----------------+
# | id                    | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | name                  | varchar(64)      | YES  | UNI | NULL    |                |
# | description           | varchar(255)     | YES  |     | NULL    |                |
# | version               | varchar(32)      | YES  |     | NULL    |                |
# | contact_id            | int(10) unsigned | YES  | MUL | NULL    |                |
# | locales               | text             | YES  |     | NULL    |                |
# | locale_custom_strings | text             | YES  |     | NULL    |                |
# +-----------------------+------------------+------+-----+---------+----------------+

class CIVICRM::Domain < CIVICRM::Base



end
