# +----------------------+------------------+------+-----+---------+----------------+
# | Field                | Type             | Null | Key | Default | Extra          |
# +----------------------+------------------+------+-----+---------+----------------+
# | id                   | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | contact_id_a         | int(10) unsigned | NO   | MUL | NULL    |                |
# | contact_id_b         | int(10) unsigned | NO   | MUL | NULL    |                |
# | relationship_type_id | int(10) unsigned | NO   | MUL | NULL    |                |
# | start_date           | date             | YES  |     | NULL    |                |
# | end_date             | date             | YES  |     | NULL    |                |
# | is_active            | tinyint(4)       | YES  |     | 1       |                |
# | description          | varchar(255)     | YES  |     | NULL    |                |
# | is_permission_a_b    | tinyint(4)       | YES  |     | 0       |                |
# | is_permission_b_a    | tinyint(4)       | YES  |     | 0       |                |
# | case_id              | int(10) unsigned | YES  | MUL | NULL    |                |
# +----------------------+------------------+------+-----+---------+----------------+

# This model is to relate one contact to another
# This can be an individual to a household (contact_type in contact model)

# Types are found in CIVICRM::RelationshipType model

class CIVICRM::Relationship < CIVICRM::Base

  validate :contacts_exists, :relationship_type_exists


  private

  def contacts_exists
    if !CIVICRM::Contact.exists?(contact_id_a)
      errors.add(:contact_id_a, "contact_id_a does not exists #{contact_id_a}")
    end

    if !CIVICRM::Contact.exists?(contact_id_b)
      errors.add(:contact_id_a, "contact_id_b does not exists #{contact_id_b}")
    end
  end

  def relationship_type_exists
    if !CIVICRM::RelationshipType.exists?(relationship_type_id)
      errors.add(:relationship_type_id, "relationship_type_id does not exist #{relationship_type_id}")
    end
  end

end
