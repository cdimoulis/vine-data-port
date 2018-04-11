# +---------------------+------------------+------+-----+---------+----------------+
# | Field               | Type             | Null | Key | Default | Extra          |
# +---------------------+------------------+------+-----+---------+----------------+
# | id                  | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | name                | varchar(255)     | NO   |     | NULL    |                |
# | title               | varchar(255)     | YES  |     | NULL    |                |
# | description         | text             | YES  |     | NULL    |                |
# | start_date          | datetime         | YES  |     | NULL    |                |
# | end_date            | datetime         | YES  |     | NULL    |                |
# | campaign_type_id    | int(10) unsigned | YES  | MUL | NULL    |                |
# | status_id           | int(10) unsigned | YES  | MUL | NULL    |                |
# | external_identifier | varchar(32)      | YES  | UNI | NULL    |                |
# | parent_id           | int(10) unsigned | YES  | MUL | NULL    |                |
# | is_active           | tinyint(4)       | YES  |     | 1       |                |
# | created_id          | int(10) unsigned | YES  | MUL | NULL    |                |
# | created_date        | datetime         | YES  |     | NULL    |                |
# | last_modified_id    | int(10) unsigned | YES  | MUL | NULL    |                |
# | last_modified_date  | datetime         | YES  |     | NULL    |                |
# | goal_general        | text             | YES  |     | NULL    |                |
# | goal_revenue        | decimal(20,2)    | YES  |     | NULL    |                |
# +---------------------+------------------+------+-----+---------+----------------+

# See Option Groups:
#   52: campaign_type
#   53: campaign_status

# Option Group 52: campaign_type (USE VALUE NOT ID)
#   334: 1 - Direct Mail
#   335: 2 - Referral Program
#   336: 3 - Constituent Engagement
#   676: 4 - Bag Hunger

# Option Group 53: campaign_status (USE VALUE NOT ID)
#   337: 1 - Planned
#   338: 2 - In Progress
#   339: 3 - Completed
#   340: 4 - Cancelled

# F1 Pledge Drives
#   3306 - Test
#   4456 - North Building
#   7888 - 2013 Church Plant Offering
#   11386 - Valley Springs Offering
#   12580 - North Pines Offering
#   14476 - Christland Offering


class CIVICRM::Campaign < CIVICRM::Base

  has_many :contributions, foreign_key: 'campaign_id', class_name: CIVICRM::Contribution

  # This is different than normal. We don't have a F1 Pledge Drive model since
  # it is not accessible from the API. This was all taken off F1 manually
  def self.f1_pledge_drives
    ['Test', 'North Building', '2013 Church Plant Offering',
     'Valley Springs Offering', 'North Pines Offering', 'Christland Offering']
  end

  def self.build_models
    f1_pledge_drives.each do |d|
      m = civicrm_model(d)
      if !m.valid || !m.save
        raise "Invalid Campaign model#{d}\n#{m.errors.inspect}\n\n"
      end
    end
  end


  def self.civicrm_model(name)
    self.new(
      name: name
    )
  end


end
