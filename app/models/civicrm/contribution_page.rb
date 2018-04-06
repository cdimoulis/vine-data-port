# +--------------------------+------------------+------+-----+---------+----------------+
# | Field                    | Type             | Null | Key | Default | Extra          |
# +--------------------------+------------------+------+-----+---------+----------------+
# | id                       | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | title                    | varchar(255)     | YES  |     | NULL    |                |
# | intro_text               | text             | YES  |     | NULL    |                |
# | financial_type_id        | int(10) unsigned | YES  | MUL | NULL    |                |
# | payment_processor        | varchar(128)     | YES  |     | NULL    |                |
# | is_credit_card_only      | tinyint(4)       | YES  |     | 0       |                |
# | is_monetary              | tinyint(4)       | YES  |     | 1       |                |
# | is_recur                 | tinyint(4)       | YES  |     | 0       |                |
# | is_confirm_enabled       | tinyint(4)       | YES  |     | 1       |                |
# | recur_frequency_unit     | varchar(128)     | YES  |     | NULL    |                |
# | is_recur_interval        | tinyint(4)       | YES  |     | 0       |                |
# | is_recur_installments    | tinyint(4)       | YES  |     | 0       |                |
# | adjust_recur_start_date  | tinyint(4)       | NO   |     | 0       |                |
# | is_pay_later             | tinyint(4)       | YES  |     | 0       |                |
# | pay_later_text           | text             | YES  |     | NULL    |                |
# | pay_later_receipt        | text             | YES  |     | NULL    |                |
# | is_partial_payment       | tinyint(4)       | YES  |     | 0       |                |
# | initial_amount_label     | varchar(255)     | YES  |     | NULL    |                |
# | initial_amount_help_text | text             | YES  |     | NULL    |                |
# | min_initial_amount       | decimal(20,2)    | YES  |     | NULL    |                |
# | is_allow_other_amount    | tinyint(4)       | YES  |     | 0       |                |
# | default_amount_id        | int(10) unsigned | YES  |     | NULL    |                |
# | min_amount               | decimal(20,2)    | YES  |     | NULL    |                |
# | max_amount               | decimal(20,2)    | YES  |     | NULL    |                |
# | goal_amount              | decimal(20,2)    | YES  |     | NULL    |                |
# | thankyou_title           | varchar(255)     | YES  |     | NULL    |                |
# | thankyou_text            | text             | YES  |     | NULL    |                |
# | thankyou_footer          | text             | YES  |     | NULL    |                |
# | is_email_receipt         | tinyint(4)       | YES  |     | 0       |                |
# | receipt_from_name        | varchar(255)     | YES  |     | NULL    |                |
# | receipt_from_email       | varchar(255)     | YES  |     | NULL    |                |
# | cc_receipt               | varchar(255)     | YES  |     | NULL    |                |
# | bcc_receipt              | varchar(255)     | YES  |     | NULL    |                |
# | receipt_text             | text             | YES  |     | NULL    |                |
# | is_active                | tinyint(4)       | YES  |     | NULL    |                |
# | footer_text              | text             | YES  |     | NULL    |                |
# | amount_block_is_active   | tinyint(4)       | YES  |     | 1       |                |
# | start_date               | datetime         | YES  |     | NULL    |                |
# | end_date                 | datetime         | YES  |     | NULL    |                |
# | created_id               | int(10) unsigned | YES  | MUL | NULL    |                |
# | created_date             | datetime         | YES  |     | NULL    |                |
# | currency                 | varchar(3)       | YES  |     | NULL    |                |
# | campaign_id              | int(10) unsigned | YES  | MUL | NULL    |                |
# | is_share                 | tinyint(4)       | YES  |     | 1       |                |
# | is_billing_required      | tinyint(4)       | YES  |     | 0       |                |
# +--------------------------+------------------+------+-----+---------+----------------+

class CIVICRM::ContributionPage < CIVICRM::Base



end
