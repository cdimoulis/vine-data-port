# +--------------------+------------------+------+-----+---------+----------------+
# | Field              | Type             | Null | Key | Default | Extra          |
# +--------------------+------------------+------+-----+---------+----------------+
# | id                 | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | domain_id          | int(10) unsigned | NO   | MUL | NULL    |                |
# | run_frequency      | varchar(8)       | YES  |     | Daily   |                |
# | last_run           | datetime         | YES  |     | NULL    |                |
# | scheduled_run_date | timestamp        | YES  |     | NULL    |                |
# | name               | varchar(255)     | YES  |     | NULL    |                |
# | description        | varchar(255)     | YES  |     | NULL    |                |
# | api_entity         | varchar(255)     | YES  |     | NULL    |                |
# | api_action         | varchar(255)     | YES  |     | NULL    |                |
# | parameters         | text             | YES  |     | NULL    |                |
# | is_active          | tinyint(4)       | YES  |     | NULL    |                |
# +--------------------+------------------+------+-----+---------+----------------+

class CIVICRM::Job < CIVICRM::Base



end
