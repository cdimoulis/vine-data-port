# +-------------------------------+------------------+------+-----+---------+----------------+
# | Field                         | Type             | Null | Key | Default | Extra          |
# +-------------------------------+------------------+------+-----+---------+----------------+
# | id                            | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | contact_id                    | int(10) unsigned | YES  | MUL | NULL    |                |
# | location_type_id              | int(10) unsigned | YES  | MUL | NULL    |                |
# | is_primary                    | tinyint(4)       | YES  | MUL | 0       |                |
# | is_billing                    | tinyint(4)       | YES  | MUL | 0       |                |
# | street_address                | varchar(96)      | YES  | MUL | NULL    |                |
# | street_number                 | int(11)          | YES  |     | NULL    |                |
# | street_number_suffix          | varchar(8)       | YES  |     | NULL    |                |
# | street_number_predirectional  | varchar(8)       | YES  |     | NULL    |                |
# | street_name                   | varchar(64)      | YES  | MUL | NULL    |                |
# | street_type                   | varchar(8)       | YES  |     | NULL    |                |
# | street_number_postdirectional | varchar(8)       | YES  |     | NULL    |                |
# | street_unit                   | varchar(16)      | YES  |     | NULL    |                |
# | supplemental_address_1        | varchar(96)      | YES  |     | NULL    |                |
# | supplemental_address_2        | varchar(96)      | YES  |     | NULL    |                |
# | supplemental_address_3        | varchar(96)      | YES  |     | NULL    |                |
# | city                          | varchar(64)      | YES  | MUL | NULL    |                |
# | county_id                     | int(10) unsigned | YES  | MUL | NULL    |                |
# | state_province_id             | int(10) unsigned | YES  | MUL | NULL    |                |
# | postal_code_suffix            | varchar(12)      | YES  |     | NULL    |                |
# | postal_code                   | varchar(64)      | YES  |     | NULL    |                |
# | usps_adc                      | varchar(32)      | YES  |     | NULL    |                |
# | country_id                    | int(10) unsigned | YES  | MUL | NULL    |                |
# | geo_code_1                    | double           | YES  |     | NULL    |                |
# | geo_code_2                    | double           | YES  |     | NULL    |                |
# | manual_geo_code               | tinyint(4)       | YES  |     | 0       |                |
# | timezone                      | varchar(8)       | YES  |     | NULL    |                |
# | name                          | varchar(255)     | YES  |     | NULL    |                |
# | master_id                     | int(10) unsigned | YES  | MUL | NULL    |                |
# +-------------------------------+------------------+------+-----+---------+----------------+

class CIVICRM::Address < CIVICRM::Base


end
