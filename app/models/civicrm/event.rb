# +-------------------------------+------------------+------+-----+---------+----------------+
# | Field                         | Type             | Null | Key | Default | Extra          |
# +-------------------------------+------------------+------+-----+---------+----------------+
# | id                            | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | title                         | varchar(255)     | YES  |     | NULL    |                |
# | summary                       | text             | YES  |     | NULL    |                |
# | description                   | text             | YES  |     | NULL    |                |
# | event_type_id                 | int(10) unsigned | YES  | MUL | 0       |                |
# | participant_listing_id        | int(10) unsigned | YES  | MUL | 0       |                |
# | is_public                     | tinyint(4)       | YES  |     | 1       |                |
# | start_date                    | datetime         | YES  |     | NULL    |                |
# | end_date                      | datetime         | YES  |     | NULL    |                |
# | is_online_registration        | tinyint(4)       | YES  |     | 0       |                |
# | registration_link_text        | varchar(255)     | YES  |     | NULL    |                |
# | registration_start_date       | datetime         | YES  |     | NULL    |                |
# | registration_end_date         | datetime         | YES  |     | NULL    |                |
# | max_participants              | int(10) unsigned | YES  |     | NULL    |                |
# | event_full_text               | text             | YES  |     | NULL    |                |
# | is_monetary                   | tinyint(4)       | YES  |     | 0       |                |
# | financial_type_id             | int(10) unsigned | YES  |     | NULL    |                |
# | payment_processor             | varchar(128)     | YES  |     | NULL    |                |
# | is_map                        | tinyint(4)       | YES  |     | 0       |                |
# | is_active                     | tinyint(4)       | YES  |     | 0       |                |
# | fee_label                     | varchar(255)     | YES  |     | NULL    |                |
# | is_show_location              | tinyint(4)       | YES  |     | 1       |                |
# | loc_block_id                  | int(10) unsigned | YES  | MUL | NULL    |                |
# | default_role_id               | int(10) unsigned | YES  |     | 1       |                |
# | intro_text                    | text             | YES  |     | NULL    |                |
# | footer_text                   | text             | YES  |     | NULL    |                |
# | confirm_title                 | varchar(255)     | YES  |     | NULL    |                |
# | confirm_text                  | text             | YES  |     | NULL    |                |
# | confirm_footer_text           | text             | YES  |     | NULL    |                |
# | is_email_confirm              | tinyint(4)       | YES  |     | 0       |                |
# | confirm_email_text            | text             | YES  |     | NULL    |                |
# | confirm_from_name             | varchar(255)     | YES  |     | NULL    |                |
# | confirm_from_email            | varchar(255)     | YES  |     | NULL    |                |
# | cc_confirm                    | varchar(255)     | YES  |     | NULL    |                |
# | bcc_confirm                   | varchar(255)     | YES  |     | NULL    |                |
# | default_fee_id                | int(10) unsigned | YES  |     | NULL    |                |
# | default_discount_fee_id       | int(10) unsigned | YES  |     | NULL    |                |
# | thankyou_title                | varchar(255)     | YES  |     | NULL    |                |
# | thankyou_text                 | text             | YES  |     | NULL    |                |
# | thankyou_footer_text          | text             | YES  |     | NULL    |                |
# | is_pay_later                  | tinyint(4)       | YES  |     | 0       |                |
# | pay_later_text                | text             | YES  |     | NULL    |                |
# | pay_later_receipt             | text             | YES  |     | NULL    |                |
# | is_partial_payment            | tinyint(4)       | YES  |     | 0       |                |
# | initial_amount_label          | varchar(255)     | YES  |     | NULL    |                |
# | initial_amount_help_text      | text             | YES  |     | NULL    |                |
# | min_initial_amount            | decimal(20,2)    | YES  |     | NULL    |                |
# | is_multiple_registrations     | tinyint(4)       | YES  |     | 0       |                |
# | max_additional_participants   | int(10) unsigned | YES  |     | 0       |                |
# | allow_same_participant_emails | tinyint(4)       | YES  |     | 0       |                |
# | has_waitlist                  | tinyint(4)       | YES  |     | NULL    |                |
# | requires_approval             | tinyint(4)       | YES  |     | NULL    |                |
# | expiration_time               | int(10) unsigned | YES  |     | NULL    |                |
# | waitlist_text                 | text             | YES  |     | NULL    |                |
# | approval_req_text             | text             | YES  |     | NULL    |                |
# | is_template                   | tinyint(4)       | NO   |     | 0       |                |
# | template_title                | varchar(255)     | YES  |     | NULL    |                |
# | created_id                    | int(10) unsigned | YES  | MUL | NULL    |                |
# | created_date                  | datetime         | YES  |     | NULL    |                |
# | currency                      | varchar(3)       | YES  |     | NULL    |                |
# | campaign_id                   | int(10) unsigned | YES  | MUL | NULL    |                |
# | is_share                      | tinyint(4)       | YES  |     | 1       |                |
# | is_confirm_enabled            | tinyint(4)       | YES  |     | 1       |                |
# | parent_event_id               | int(10) unsigned | YES  | MUL | NULL    |                |
# | slot_label_id                 | int(10) unsigned | YES  |     | NULL    |                |
# | dedupe_rule_group_id          | int(10) unsigned | YES  | MUL | NULL    |                |
# | is_billing_required           | tinyint(4)       | YES  |     | 0       |                |
# | selfcancelxfer_time           | int(10) unsigned | YES  |     | 0       |                |
# | allow_selfcancelxfer          | tinyint(4)       | YES  |     | 0       |                |
# +-------------------------------+------------------+------+-----+---------+----------------+

class CIVICRM::Event < CIVICRM::Base

  belongs_to :contact, foreign_key: 'contact_id', class_name: CIVICRM::Contact

end
