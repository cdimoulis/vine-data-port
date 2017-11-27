# +-------------+------------------+------+-----+---------+----------------+
# | Field       | Type             | Null | Key | Default | Extra          |
# +-------------+------------------+------+-----+---------+----------------+
# | id          | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | name        | varchar(64)      | YES  | UNI | NULL    |                |
# | label       | varchar(64)      | YES  |     | NULL    |                |
# | description | text             | YES  |     | NULL    |                |
# | image_URL   | varchar(255)     | YES  |     | NULL    |                |
# | parent_id   | int(10) unsigned | YES  | MUL | NULL    |                |
# | is_active   | tinyint(4)       | YES  |     | NULL    |                |
# | is_reserved | tinyint(4)       | YES  |     | NULL    |                |
# +-------------+------------------+------+-----+---------+----------------+

# This is used for the CIVICRM::Contact model
# Contact.contact_type contains the name of a model where parent_id: nil
# Contact.contact_sub_type contains the name of a model where not parent_id: nil


class CIVICRM::ContactType < CIVICRM::Base

  has_many :contacts, class_name: CIVICRM::Contact.name, inverse_of: :contact_type_model, foreign_key: 'contact_type', primary_key: 'name'

end
