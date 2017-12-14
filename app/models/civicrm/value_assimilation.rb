# +-------------------------------------+------------------+------+-----+---------+----------------+
# | Field                               | Type             | Null | Key | Default | Extra          |
# +-------------------------------------+------------------+------+-----+---------+----------------+
# | id                                  | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | entity_id                           | int(10) unsigned | NO   | UNI | NULL    |                |
# | foundations_truth_17                | datetime         | YES  | MUL | NULL    |                |
# | foundations_freedom_18              | datetime         | YES  | MUL | NULL    |                |
# | foundations_service_19              | datetime         | YES  | MUL | NULL    |                |
# | foundations_community_20            | datetime         | YES  | MUL | NULL    |                |
# | membership_approved_22              | datetime         | YES  | MUL | NULL    |                |
# | membership_application_filed_dat_23 | datetime         | YES  |     | NULL    |                |
# | membership_letter_sent_40           | varchar(255)     | YES  | MUL | NULL    |                |
# | membership_status_101               | varchar(255)     | YES  | MUL | NA      |                |
# | membership_inactive_since_102       | datetime         | YES  |     | NULL    |                |
# | mbt_week_1_165                      | datetime         | YES  | MUL | NULL    |                |
# | mbt_week_2_166                      | datetime         | YES  | MUL | NULL    |                |
# | mbt_week_3_167                      | datetime         | YES  | MUL | NULL    |                |
# | mbt_week_4_168                      | datetime         | YES  | MUL | NULL    |                |
# | mbt_week_5_169                      | datetime         | YES  | MUL | NULL    |                |
# | mbt_week_6_170                      | datetime         | YES  | MUL | NULL    |                |
# +-------------------------------------+------------------+------+-----+---------+----------------+

##
# For membership tracking
##

class CIVICRM::ValueAssimilation < CIVICRM::Base

  def self.table_name
    'civicrm_value_assimilations_4'
  end
end
