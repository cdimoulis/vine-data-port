# +--------------+------------------+------+-----+---------+----------------+
# | Field        | Type             | Null | Key | Default | Extra          |
# +--------------+------------------+------+-----+---------+----------------+
# | id           | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | name         | varchar(64)      | YES  | UNI | NULL    |                |
# | display_name | varchar(64)      | YES  |     | NULL    |                |
# | vcard_name   | varchar(64)      | YES  |     | NULL    |                |
# | description  | varchar(255)     | YES  |     | NULL    |                |
# | is_reserved  | tinyint(4)       | YES  |     | NULL    |                |
# | is_active    | tinyint(4)       | YES  |     | NULL    |                |
# | is_default   | tinyint(4)       | YES  |     | NULL    |                |
# +--------------+------------------+------+-----+---------+----------------+

# 1: Home
# 2: Work
# 3: Main
# 4: Other
# 5: Billing
# 6: Primary
# 7: Secondary
# 8: College
# 9: Vacation
# 10: Business
# 11: Org
# 12: Previous
# 13: Statement
# 14: Mail Returned Incorrect


class CIVICRM::LocationType < CIVICRM::Base

  def self.print_names
    str = ''
    self.all.each do |r|
      str += "#{r.id}: #{r.name}\n"
    end

    puts str
  end
end
