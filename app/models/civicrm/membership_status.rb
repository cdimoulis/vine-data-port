# +-----------------------------+------------------+------+-----+---------+----------------+
# | Field                       | Type             | Null | Key | Default | Extra          |
# +-----------------------------+------------------+------+-----+---------+----------------+
# | id                          | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | name                        | varchar(128)     | YES  |     | NULL    |                |
# | label                       | varchar(128)     | YES  |     | NULL    |                |
# | start_event                 | varchar(12)      | YES  |     | NULL    |                |
# | start_event_adjust_unit     | varchar(8)       | YES  |     | NULL    |                |
# | start_event_adjust_interval | int(11)          | YES  |     | NULL    |                |
# | end_event                   | varchar(12)      | YES  |     | NULL    |                |
# | end_event_adjust_unit       | varchar(8)       | YES  |     | NULL    |                |
# | end_event_adjust_interval   | int(11)          | YES  |     | NULL    |                |
# | is_current_member           | tinyint(4)       | YES  |     | NULL    |                |
# | is_admin                    | tinyint(4)       | YES  |     | NULL    |                |
# | weight                      | int(11)          | YES  |     | NULL    |                |
# | is_default                  | tinyint(4)       | YES  |     | NULL    |                |
# | is_active                   | tinyint(4)       | YES  |     | 1       |                |
# | is_reserved                 | tinyint(4)       | YES  |     | 0       |                |
# +-----------------------------+------------------+------+-----+---------+----------------+

####
# THIS IS FOR SERVING Membership
####

class CIVICRM::MembershipStatus < CIVICRM::Base


end
