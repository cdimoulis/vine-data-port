# +--------------------------+------------------+------+-----+---------+----------------+
# | Field                    | Type             | Null | Key | Default | Extra          |
# +--------------------------+------------------+------+-----+---------+----------------+
# | id                       | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | contact_id               | int(10) unsigned | NO   | MUL | NULL    |                |
# | financial_type_id        | int(10) unsigned | YES  | MUL | NULL    |                |
# | contribution_page_id     | int(10) unsigned | YES  | MUL | NULL    |                |
# | payment_instrument_id    | int(10) unsigned | YES  | MUL | NULL    |                |
# | receive_date             | datetime         | YES  | MUL | NULL    |                |
# | non_deductible_amount    | decimal(20,2)    | YES  |     | 0.00    |                |
# | total_amount             | decimal(20,2)    | NO   | MUL | NULL    |                |
# | fee_amount               | decimal(20,2)    | YES  |     | NULL    |                |
# | net_amount               | decimal(20,2)    | YES  |     | NULL    |                |
# | trxn_id                  | varchar(255)     | YES  | UNI | NULL    |                |
# | invoice_id               | varchar(255)     | YES  | UNI | NULL    |                |
# | currency                 | varchar(3)       | YES  |     | NULL    |                |
# | cancel_date              | datetime         | YES  |     | NULL    |                |
# | cancel_reason            | text             | YES  |     | NULL    |                |
# | receipt_date             | datetime         | YES  |     | NULL    |                |
# | thankyou_date            | datetime         | YES  |     | NULL    |                |
# | source                   | varchar(255)     | YES  | MUL | NULL    |                |
# | amount_level             | text             | YES  |     | NULL    |                |
# | contribution_recur_id    | int(10) unsigned | YES  | MUL | NULL    |                |
# | is_test                  | tinyint(4)       | YES  |     | 0       |                |
# | is_pay_later             | tinyint(4)       | YES  |     | 0       |                |
# | contribution_status_id   | int(10) unsigned | YES  | MUL | 1       |                |
# | address_id               | int(10) unsigned | YES  | MUL | NULL    |                |
# | check_number             | varchar(255)     | YES  | MUL | NULL    |                |
# | campaign_id              | int(10) unsigned | YES  | MUL | NULL    |                |
# | tax_amount               | decimal(20,2)    | YES  |     | NULL    |                |
# | creditnote_id            | varchar(255)     | YES  | MUL | NULL    |                |
# | revenue_recognition_date | datetime         | YES  |     | NULL    |                |
# +--------------------------+------------------+------+-----+---------+----------------+

# contribution_status_id is found in the Option Value Table as option_group_id = 11
# or OptionGroup name = contribution_status
#   74: 1 - Completed
#   75: 2 - Pending
#   76: 3 - Cancelled
#   77: 4 - Failed
#   78: 5 - In Progress
#   79: 6 - Overdue
#   826: 7 - Refunded
#   897: 8 - Partially paid
#   898: 9 - Pending refund
#   1061: 10 - Chargeback

# payment_instrument_id is found in the Option Value Table as option_group_id = 10
# or OptionGroup name = payment_instrument
# 69: 1 - Credit Card
# 70: 2 - Debit Card
# 71: 3 - Cash
# 72: 4 - Check
# 73: 5 - EFT
# 795: 6 - Stock

# FinancialTypes original names =
# 1, "Donation"
# 2, "Member Dues"
# 3, "Campaign Contribution"
# 4, "Event Fee"
# 5, "None"
# 6, "Volunteer"
# 7, "Tithe"
# 8, "Offering"
# 9, "Land Offering"
# 10, "Building Offering"
# 11, "Church Plant Offering"]


# F1 Pledge Drives which will be mapped to campaigns
#   3306 - Test
#   4456 - North Building
#   7888 - 2013 Church Plant Offering
#   11386 - Valley Springs Offering
#   12580 - North Pines Offering
#   14476 - Christland Offering

# trxn_id probably ties to civicrm_financial_trxn table


class CIVICRM::Contribution < CIVICRM::Base

  belongs_to :campaign, foreign_key: 'campaign_id', class_name: CIVICRM::Campaign.name

  validates :contact_id, presence: true

end
