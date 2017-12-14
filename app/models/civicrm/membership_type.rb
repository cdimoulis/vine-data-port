# +---------------------------+------------------+------+-----+---------+----------------+
# | Field                     | Type             | Null | Key | Default | Extra          |
# +---------------------------+------------------+------+-----+---------+----------------+
# | id                        | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | domain_id                 | int(10) unsigned | NO   | MUL | NULL    |                |
# | name                      | varchar(128)     | YES  |     | NULL    |                |
# | description               | varchar(255)     | YES  |     | NULL    |                |
# | member_of_contact_id      | int(10) unsigned | NO   | MUL | NULL    |                |
# | financial_type_id         | int(10) unsigned | NO   | MUL | NULL    |                |
# | minimum_fee               | decimal(20,2)    | YES  |     | 0.00    |                |
# | duration_unit             | varchar(8)       | YES  |     | NULL    |                |
# | duration_interval         | int(11)          | YES  |     | NULL    |                |
# | period_type               | varchar(8)       | YES  |     | NULL    |                |
# | fixed_period_start_day    | int(11)          | YES  |     | NULL    |                |
# | fixed_period_rollover_day | int(11)          | YES  |     | NULL    |                |
# | relationship_type_id      | varchar(64)      | YES  | MUL | NULL    |                |
# | relationship_direction    | varchar(128)     | YES  |     | NULL    |                |
# | max_related               | int(11)          | YES  |     | NULL    |                |
# | visibility                | varchar(64)      | YES  |     | NULL    |                |
# | weight                    | int(11)          | YES  |     | NULL    |                |
# | receipt_text_signup       | varchar(255)     | YES  |     | NULL    |                |
# | receipt_text_renewal      | varchar(255)     | YES  |     | NULL    |                |
# | auto_renew                | tinyint(4)       | YES  |     | 0       |                |
# | is_active                 | tinyint(4)       | YES  |     | 1       |                |
# +---------------------------+------------------+------+-----+---------+----------------+

####
# THIS IS FOR SERVING Membership
####

class CIVICRM::MembershipType < CIVICRM::Base

end
