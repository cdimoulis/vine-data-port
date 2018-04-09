# +---------------+------------------+------+-----+---------+----------------+
# | Field         | Type             | Null | Key | Default | Extra          |
# +---------------+------------------+------+-----+---------+----------------+
# | id            | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | name          | varchar(64)      | NO   |     | NULL    |                |
# | description   | varchar(255)     | YES  |     | NULL    |                |
# | is_deductible | tinyint(4)       | YES  |     | 1       |                |
# | is_reserved   | tinyint(4)       | YES  |     | NULL    |                |
# | is_active     | tinyint(4)       | YES  |     | NULL    |                |
# +---------------+------------------+------+-----+---------+----------------+

# Original Names:
#     Donation
#     Member Dues
#     Campaign Contribution
#     Event Fee
#     None
#     Volunteer
#     Tithe
#     Offering
#     Land Offering
#     Building Offering
#     Church Plant Offering

class CIVICRM::FinancialType < CIVICRM::Base



end
