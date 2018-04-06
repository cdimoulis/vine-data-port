# +--------------------------------+------------------+------+-----+-------------------+-----------------------------+
# | Field                          | Type             | Null | Key | Default           | Extra                       |
# +--------------------------------+------------------+------+-----+-------------------+-----------------------------+
# | id                             | int(10) unsigned | NO   | PRI | NULL              | auto_increment              |
# | contact_type                   | varchar(64)      | YES  | MUL | NULL              |                             |
# | contact_sub_type               | varchar(255)     | YES  | MUL | NULL              |                             |
# | do_not_email                   | tinyint(4)       | YES  |     | 0                 |                             |
# | do_not_phone                   | tinyint(4)       | YES  |     | 0                 |                             |
# | do_not_mail                    | tinyint(4)       | YES  |     | 0                 |                             |
# | do_not_sms                     | tinyint(4)       | YES  |     | 0                 |                             |
# | do_not_trade                   | tinyint(4)       | YES  |     | 0                 |                             |
# | is_opt_out                     | tinyint(4)       | NO   |     | 0                 |                             |
# | legal_identifier               | varchar(32)      | YES  |     | NULL              |                             |
# | external_identifier            | varchar(64)      | YES  | UNI | NULL              |                             |
# | sort_name                      | varchar(128)     | YES  | MUL | NULL              |                             |
# | display_name                   | varchar(128)     | YES  |     | NULL              |                             |
# | nick_name                      | varchar(128)     | YES  |     | NULL              |                             |
# | legal_name                     | varchar(128)     | YES  |     | NULL              |                             |
# | image_URL                      | text             | YES  | MUL | NULL              |                             |
# | preferred_communication_method | varchar(255)     | YES  | MUL | NULL              |                             |
# | preferred_language             | varchar(5)       | YES  |     | NULL              |                             |
# | preferred_mail_format          | varchar(8)       | YES  |     | Both              |                             |
# | hash_key                       | varchar(32)      | YES  | MUL | NULL              |                             |
# | api_key                        | varchar(32)      | YES  | MUL | NULL              |                             |
# | source                         | varchar(255)     | YES  |     | NULL              |                             |
# | first_name                     | varchar(64)      | YES  | MUL | NULL              |                             |
# | middle_name                    | varchar(64)      | YES  |     | NULL              |                             |
# | last_name                      | varchar(64)      | YES  | MUL | NULL              |                             |
# | prefix_id                      | int(10) unsigned | YES  | MUL | NULL              |                             |
# | suffix_id                      | int(10) unsigned | YES  | MUL | NULL              |                             |
# | formal_title                   | varchar(64)      | YES  |     | NULL              |                             |
# | communication_style_id         | int(10) unsigned | YES  | MUL | NULL              |                             |
# | email_greeting_id              | int(10) unsigned | YES  |     | NULL              |                             |
# | email_greeting_custom          | varchar(128)     | YES  |     | NULL              |                             |
# | email_greeting_display         | varchar(255)     | YES  |     | NULL              |                             |
# | postal_greeting_id             | int(10) unsigned | YES  |     | NULL              |                             |
# | postal_greeting_custom         | varchar(128)     | YES  |     | NULL              |                             |
# | postal_greeting_display        | varchar(255)     | YES  |     | NULL              |                             |
# | addressee_id                   | int(10) unsigned | YES  |     | NULL              |                             |
# | addressee_custom               | varchar(128)     | YES  |     | NULL              |                             |
# | addressee_display              | varchar(255)     | YES  |     | NULL              |                             |
# | job_title                      | varchar(255)     | YES  |     | NULL              |                             |
# | gender_id                      | int(10) unsigned | YES  | MUL | NULL              |                             |
# | birth_date                     | date             | YES  | MUL | NULL              |                             |
# | is_deceased                    | tinyint(4)       | YES  |     | 0                 |                             |
# | deceased_date                  | date             | YES  |     | NULL              |                             |
# | household_name                 | varchar(128)     | YES  | MUL | NULL              |                             |
# | primary_contact_id             | int(10) unsigned | YES  | MUL | NULL              |                             |
# | organization_name              | varchar(128)     | YES  | MUL | NULL              |                             |
# | sic_code                       | varchar(8)       | YES  |     | NULL              |                             |
# | user_unique_id                 | varchar(255)     | YES  |     | NULL              |                             |
# | employer_id                    | int(10) unsigned | YES  | MUL | NULL              |                             |
# | is_deleted                     | tinyint(4)       | NO   | MUL | 0                 |                             |
# | created_date                   | timestamp        | YES  |     | NULL              |                             |
# | modified_date                  | timestamp        | YES  |     | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |
# +--------------------------------+------------------+------+-----+-------------------+-----------------------------+

# CIVICRM::ContactType contains the contact_type and contact_sub_type

# Relationships between contacts are found in CIVICRM::Relationship model

class CIVICRM::Contact < CIVICRM::Base

  # RENAME ON EXPORT
  # hash_key to hash

  # Associations
  # The `email_greeting_id` references the `value` attribute in `OptionValue` where `OptionGroup` is `email_greeting`
  belongs_to :email_greeting, -> { where option_group_id: CIVICRM::OptionGroup.where(name: 'email_greeting').take.id }, foreign_key: 'email_greeting_id', class_name: CIVICRM::OptionValue.name, primary_key: 'value'
  belongs_to :prefix, -> { where option_group_id: CIVICRM::OptionGroup.where(name: 'individual_prefix').take.id }, foreign_key: 'prefix_id', class_name: CIVICRM::OptionValue.name, primary_key: 'value'
  belongs_to :suffix, -> { where option_group_id: CIVICRM::OptionGroup.where(name: 'individual_suffix').take.id }, foreign_key: 'suffix_id', class_name: CIVICRM::OptionValue.name, primary_key: 'value'
  belongs_to :contact_type_model, foreign_key: 'contact_type', class_name: CIVICRM::ContactType.name, primary_key: 'name'
  belongs_to :contact_sub_type_model, foreign_key: 'contact_sub_type', class_name: CIVICRM::ContactType.name, primary_key: 'name'
  belongs_to :communication_style, -> { where option_group_id: CIVICRM::OptionGroup.where(name: 'communication_style').take.id }, foreign_key: 'communication_style_id', class_name: CIVICRM::OptionValue.name, primary_key: 'value'
  belongs_to :addressee, -> { where option_group_id: CIVICRM::OptionGroup.where(name: 'addressee').take.id }, foreign_key: 'addressee_id', class_name: CIVICRM::OptionValue.name, primary_key: 'value'
  belongs_to :gender, -> { where option_group_id: CIVICRM::OptionGroup.where(name: 'gender').take.id }, foreign_key: 'gender_id', class_name: CIVICRM::OptionValue.name, primary_key: 'value'
  has_one :vine_contact_prev_id, foreign_key: 'contact_id', class_name: CIVICRM::VineContactPrevId

  has_many :phones, foreign_key: 'contact_id', class_name: CIVICRM::Phone
  has_many :addresses, foreign_key: 'contact_id', class_name: CIVICRM::Address


  # Remove all but necessary contacts
  def self.remove_all
    self.where.not(display_name: 'Vine Church').destroy_all
  end

end
