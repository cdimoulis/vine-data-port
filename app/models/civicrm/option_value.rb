# +-----------------+------------------+------+-----+---------+----------------+
# | Field           | Type             | Null | Key | Default | Extra          |
# +-----------------+------------------+------+-----+---------+----------------+
# | id              | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
# | option_group_id | int(10) unsigned | NO   | MUL | NULL    |                |
# | label           | varchar(512)     | YES  |     | NULL    |                |
# | value           | varchar(512)     | NO   | MUL | NULL    |                |
# | name            | varchar(255)     | YES  | MUL | NULL    |                |
# | grouping        | varchar(255)     | YES  |     | NULL    |                |
# | filter          | int(10) unsigned | YES  |     | NULL    |                |
# | is_default      | tinyint(4)       | YES  |     | 0       |                |
# | weight          | int(10) unsigned | NO   |     | NULL    |                |
# | description     | text             | YES  |     | NULL    |                |
# | is_optgroup     | tinyint(4)       | YES  |     | 0       |                |
# | is_reserved     | tinyint(4)       | YES  |     | 0       |                |
# | is_active       | tinyint(4)       | YES  |     | 1       |                |
# | component_id    | int(10) unsigned | YES  | MUL | NULL    |                |
# | domain_id       | int(10) unsigned | YES  | MUL | NULL    |                |
# | visibility_id   | int(10) unsigned | YES  |     | NULL    |                |
# | icon            | varchar(255)     | YES  |     | NULL    |                |
# | color           | varchar(255)     | YES  |     | NULL    |                |
# +-----------------+------------------+------+-----+---------+----------------+
class CIVICRM::OptionValue < CIVICRM::Base

  belongs_to :option_group, class_name: CIVICRM::OptionGroup.name

  def self.get_records_by_group_id(group_id)
    self.where(option_group_id: group_id)
  end

  def self.get_records_by_group_name(name)
    group = CIVICRM::OptionGroup.where(name: name).take
    if group
      self.where(option_group_id: group.id)
    end
  end

  def self.print_name_by_group_id(group_id)
    str = ''
    get_records_by_group_id(group_id).each do |r|
      str += "#{r.id}: #{r.value} - #{r.name}\n"
    end

    puts str
  end

  def self.print_name_by_group_name(name)
    str = ''
    get_records_by_group_name(name).each do |r|
      str += "#{r.id}: #{r.value} - #{r.name}\n"
    end

    puts str
  end



  #####
  # For creating
  #####

  def self.create_new_phone_type(name)
    group = CIVICRM::OptionGroup.where(name: 'phone_type').take
    if group.present? && !self.exists?(option_group_id: group.id, name: name)
      values = self.where(option_group_id: group.id)
      weight = values.pluck('weight').max + 1

      value = self.new(
        option_group_id: group.id,
        label: name,
        value: "#{weight}",
        name: name,
        weight: weight
      )

      if value.valid? && value.save
        puts "Saved #{name} CIVICRM::OptionValue record for Phone Types\n"
      else
        puts "\n\nCould not create new option value Phone Types\n#{value.errors.inspect}\n\n"
      end
    end
  end


  # Membership status
  def self.create_new_membership_status(name)
    group = CIVICRM::OptionGroup.where(name: 'membership_status_20121112161808').take
    if group.present? && !self.exists?(option_group_id: group.id, label: name)
      values = self.where(option_group_id: group.id)
      weight = values.empty? ? 0 : values.pluck('weight').max + 1

      value = self.new(
        option_group_id: group.id,
        label: name,
        value: name,
        name: name.gsub(' ', '_'),
        weight: weight
      )

      if value.valid? && value.save
        puts "Save #{name} CIVICRM::OptionValue record for Membership Status\n"
      else
        puts "\n\nCould not create new option value for Membership Status\n#{value.errors.inspect}\n\n"
      end
    end
  end

  # FinancialType
  def self.create_new_payment_instrument(name)
    group = CIVICRM::OptionGroup.where(name: 'payment_instrument')
    if group.present? && !self.exists?(option_group_id: group.id, label: name)
      value = self.where(option_group_id: group_id)
      weight = values.empty? ? 0 : values.pluck('weight').max + 1

      value = self.new(
        option_group_id: group.id,
        label: name,
        value: weight,
        name: name,
        weight: weight
      )

      if value.valid? && value.save
        puts "Save #{name} CIVICRM::OptionValue for payment instrument\n"
      else
        puts "\n\nCoult not create a new option value for payment instrument\n#{value.errors.inspect}\n\n"
      end
    end
    value
  end
end
