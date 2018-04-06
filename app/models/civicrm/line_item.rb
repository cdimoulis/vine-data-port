# +-----------------------+------------------+------+-----+---------+----------------+
# | Field                 | Type             | Null | Key | Default | Extra          |
# +-----------------------+------------------+------+-----+---------+----------------+
# | id                    | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | entity_table          | varchar(64)      | NO   | MUL | NULL    |                |
# | entity_id             | int(10) unsigned | NO   |     | NULL    |                |
# | contribution_id       | int(10) unsigned | YES  | MUL | NULL    |                |
# | price_field_id        | int(10) unsigned | YES  | MUL | NULL    |                |
# | label                 | varchar(255)     | YES  |     | NULL    |                |
# | qty                   | decimal(20,2)    | YES  |     | NULL    |                |
# | unit_price            | decimal(20,2)    | NO   |     | NULL    |                |
# | line_total            | decimal(20,2)    | NO   |     | NULL    |                |
# | participant_count     | int(10) unsigned | YES  |     | NULL    |                |
# | price_field_value_id  | int(10) unsigned | YES  | MUL | NULL    |                |
# | financial_type_id     | int(10) unsigned | YES  | MUL | NULL    |                |
# | non_deductible_amount | decimal(20,2)    | NO   |     | 0.00    |                |
# | tax_amount            | decimal(20,2)    | YES  |     | NULL    |                |
# +-----------------------+------------------+------+-----+---------+----------------+

class CIVICRM::LineItem < CIVICRM::Base



end
