# +------------------+------------------+------+-----+---------+----------------+
# | Field            | Type             | Null | Key | Default | Extra          |
# +------------------+------------------+------+-----+---------+----------------+
# | id               | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | domain_id        | int(10) unsigned | NO   | MUL | NULL    |                |
# | path             | varchar(255)     | YES  | MUL | NULL    |                |
# | path_arguments   | text             | YES  |     | NULL    |                |
# | title            | varchar(255)     | YES  |     | NULL    |                |
# | access_callback  | varchar(255)     | YES  |     | NULL    |                |
# | access_arguments | text             | YES  |     | NULL    |                |
# | page_callback    | varchar(255)     | YES  |     | NULL    |                |
# | page_arguments   | text             | YES  |     | NULL    |                |
# | breadcrumb       | text             | YES  |     | NULL    |                |
# | return_url       | varchar(255)     | YES  |     | NULL    |                |
# | return_url_args  | varchar(255)     | YES  |     | NULL    |                |
# | component_id     | int(10) unsigned | YES  | MUL | NULL    |                |
# | is_active        | tinyint(4)       | YES  |     | NULL    |                |
# | is_public        | tinyint(4)       | YES  |     | NULL    |                |
# | is_exposed       | tinyint(4)       | YES  |     | NULL    |                |
# | is_ssl           | tinyint(4)       | YES  |     | NULL    |                |
# | weight           | int(11)          | NO   |     | 1       |                |
# | type             | int(11)          | NO   |     | 1       |                |
# | page_type        | int(11)          | NO   |     | 1       |                |
# | skipBreadcrumb   | tinyint(4)       | YES  |     | NULL    |                |
# +------------------+------------------+------+-----+---------+----------------+
class CIVICRM::Menu < CIVICRM::Base

  # Example title values
  # Individual Prefixes (Ms, Mr...)
  # Individual Suffixes (Jr, Sr...)
end
