# +------------------+------------------+------+-----+---------+----------------+
# | Field            | Type             | Null | Key | Default | Extra          |
# +------------------+------------------+------+-----+---------+----------------+
# | id               | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | contact_id       | int(10) unsigned | YES  | MUL | NULL    |                |
# | location_type_id | int(10) unsigned | YES  | MUL | NULL    |                |
# | email            | varchar(254)     | YES  | MUL | NULL    |                |
# | is_primary       | tinyint(4)       | YES  | MUL | 0       |                |
# | is_billing       | tinyint(4)       | YES  | MUL | 0       |                |
# | on_hold          | tinyint(4)       | NO   |     | 0       |                |
# | is_bulkmail      | tinyint(4)       | NO   |     | 0       |                |
# | hold_date        | datetime         | YES  |     | NULL    |                |
# | reset_date       | datetime         | YES  |     | NULL    |                |
# | signature_text   | text             | YES  |     | NULL    |                |
# | signature_html   | text             | YES  |     | NULL    |                |
# +------------------+------------------+------+-----+---------+----------------+

class CIVICRM::Email < CIVICRM::Base


end
