# +---------------------------+------------------+------+-----+---------+----------------+
# | Field                     | Type             | Null | Key | Default | Extra          |
# +---------------------------+------------------+------+-----+---------+----------------+
# | id                        | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | contact_id                | int(10) unsigned | NO   | MUL | NULL    |                |
# | event_id                  | int(10) unsigned | NO   | MUL | NULL    |                |
# | status_id                 | int(10) unsigned | NO   | MUL | 1       |                |
# | role_id                   | varchar(128)     | YES  | MUL | NULL    |                |
# | register_date             | datetime         | YES  |     | NULL    |                |
# | source                    | varchar(128)     | YES  |     | NULL    |                |
# | fee_level                 | text             | YES  |     | NULL    |                |
# | is_test                   | tinyint(4)       | YES  |     | 0       |                |
# | is_pay_later              | tinyint(4)       | YES  |     | 0       |                |
# | fee_amount                | decimal(20,2)    | YES  |     | NULL    |                |
# | registered_by_id          | int(10) unsigned | YES  | MUL | NULL    |                |
# | discount_id               | int(10) unsigned | YES  | MUL | NULL    |                |
# | fee_currency              | varchar(3)       | YES  |     | NULL    |                |
# | campaign_id               | int(10) unsigned | YES  | MUL | NULL    |                |
# | discount_amount           | int(10) unsigned | YES  |     | NULL    |                |
# | cart_id                   | int(10) unsigned | YES  | MUL | NULL    |                |
# | must_wait                 | int(11)          | YES  |     | NULL    |                |
# | transferred_to_contact_id | int(10) unsigned | YES  | MUL | NULL    |                |
# +---------------------------+------------------+------+-----+---------+----------------+

class CIVICRM::Participant < CIVICRM::Base

  belongs_to :contact, foreign_key: 'contact_id', class_name: CIVICRM::Contact

end
