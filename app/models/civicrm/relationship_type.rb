# +--------------------+------------------+------+-----+---------+----------------+
# | Field              | Type             | Null | Key | Default | Extra          |
# +--------------------+------------------+------+-----+---------+----------------+
# | id                 | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | name_a_b           | varchar(64)      | YES  | UNI | NULL    |                |
# | label_a_b          | varchar(64)      | YES  |     | NULL    |                |
# | name_b_a           | varchar(64)      | YES  | UNI | NULL    |                |
# | label_b_a          | varchar(64)      | YES  |     | NULL    |                |
# | description        | varchar(255)     | YES  |     | NULL    |                |
# | contact_type_a     | varchar(12)      | YES  |     | NULL    |                |
# | contact_type_b     | varchar(12)      | YES  |     | NULL    |                |
# | contact_sub_type_a | varchar(64)      | YES  |     | NULL    |                |
# | contact_sub_type_b | varchar(64)      | YES  |     | NULL    |                |
# | is_reserved        | tinyint(4)       | YES  |     | NULL    |                |
# | is_active          | tinyint(4)       | YES  |     | 1       |                |
# +--------------------+------------------+------+-----+---------+----------------+

# Contains the relationship information for contacts

# contact_type_a(b) is same as contact_type of CIVICRM::Contact model
# This is same for contact_type_type_a(b)
# Must be used to determine restrictions on relationship types??

class CIVICRM::RelationshipType < CIVICRM::Base


end
