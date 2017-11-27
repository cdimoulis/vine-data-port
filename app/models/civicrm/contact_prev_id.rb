# +------------+------------------+------+-----+---------+----------------+
# | Field      | Type             | Null | Key | Default | Extra          |
# +------------+------------------+------+-----+---------+----------------+
# | id         | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | contact_id | int(10) unsigned | NO   |     | NULL    |                |
# | f1_id      | int(10) unsigned | YES  |     | NULL    |                |
# | alf_id     | int(10) unsigned | YES  |     | NULL    |                |
# +------------+------------------+------+-----+---------+----------------+

### VINE CUSTOM TABLE ###

# Holds original fellowship one record id (f1_id) or the alf
# record (alf_id) for a CIVICRM::Contact model

class CIVICRM::ContactPrevId < CIVICRM::Base



end
