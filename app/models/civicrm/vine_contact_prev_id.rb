# +-----------------+------------------+------+-----+---------+----------------+
# | Field           | Type             | Null | Key | Default | Extra          |
# +-----------------+------------------+------+-----+---------+----------------+
# | id              | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | contact_id      | int(10) unsigned | NO   | MUL | NULL    |                |
# | contact_type_id | int(10) unsigned | NO   | MUL | NULL    |                |
# | f1_id           | int(10) unsigned | YES  | MUL | NULL    |                |
# | alf_id          | int(10) unsigned | YES  | MUL | NULL    |                |
# +-----------------+------------------+------+-----+---------+----------------+

### VINE CUSTOM TABLE ###

# Holds original fellowship one record id (f1_id) or the alf
# record (alf_id) for a CIVICRM::Contact model

class CIVICRM::VineContactPrevId < CIVICRM::Base

  belongs_to :contact, foreign_key: 'contact_id', class_name: CIVICRM::Contact

end
