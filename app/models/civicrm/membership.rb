# +-----------------------+------------------+------+-----+---------+----------------+
# | Field                 | Type             | Null | Key | Default | Extra          |
# +-----------------------+------------------+------+-----+---------+----------------+
# | id                    | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | contact_id            | int(10) unsigned | NO   | MUL | NULL    |                |
# | membership_type_id    | int(10) unsigned | NO   | MUL | NULL    |                |
# | join_date             | date             | YES  |     | NULL    |                |
# | start_date            | date             | YES  |     | NULL    |                |
# | end_date              | date             | YES  |     | NULL    |                |
# | source                | varchar(128)     | YES  |     | NULL    |                |
# | status_id             | int(10) unsigned | NO   | MUL | NULL    |                |
# | is_override           | tinyint(4)       | YES  |     | NULL    |                |
# | owner_membership_id   | int(10) unsigned | YES  | MUL | NULL    |                |
# | max_related           | int(11)          | YES  |     | NULL    |                |
# | is_test               | tinyint(4)       | YES  |     | 0       |                |
# | is_pay_later          | tinyint(4)       | YES  |     | 0       |                |
# | contribution_recur_id | int(10) unsigned | YES  | MUL | NULL    |                |
# | campaign_id           | int(10) unsigned | YES  | MUL | NULL    |                |
# +-----------------------+------------------+------+-----+---------+----------------+

####
# THIS IS FOR SERVING Membership
####

class CIVICRM::Membership < CIVICRM::Base

end
