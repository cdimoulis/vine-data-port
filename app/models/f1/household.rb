# == Schema Information
#
# Table name: f1_households
#
#  id                          :integer          not null, primary key
#  uri                         :string
#  old_id                      :integer
#  h_code                      :string
#  household_name              :string
#  household_sort_name         :string
#  household_first_name        :string
#  last_security_authorization :datetime
#  last_activity_date          :datetime
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#

class F1::Household < F1::Base

  has_many :people, class_name: F1::Person.name
  has_many :addresses, class_name: F1::Address.name
  has_many :communications, class_name: F1::Communication.name

  def self.base_route
    '/households'
  end

  def self.f1_attribute_map
    {
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  def self.find_attributes(force_remote=false)
    if force_remote
      self.fetch_attributes('/search', {createdDate: '1975-01-01'})
    else
      begin
        self.column_names
      rescue
        self.fetch_attributes('/search', {createdDate: '1975-01-01'})
      end
    end
  end

  def self.get_all_records(extra_route=nil, data=nil, max_pages=nil)
    data = data || {}
    super "/search", {createdDate: '1975-01-01'}.merge(data), max_pages
  end

  # SHOW IDs
  # Dimoulis 31219451

  # Total Records
  # 7/27/2017  17,826

  ####
  # CIVICRM model mapping
  ####

  # The mapping to civicrm
  def civicrm_models
    household = contact_model()
    # More stuff if needed
    household
  end

  def contact_model
    contact = CIVICRM::Contact.new(
      :contact_type => "Household",
      :contact_sub_type => "Family",
      :sort_name => self.household_sort_name,
      :display_name => self.household_name,
      :preferred_mail_format => 'Both', # Every record appears to have this
      :communication_style_id => nil,
      :email_greeting_id => nil,
      :email_greeting_custom => nil,
      :email_greeting_display => nil,
      :addressee_id => 1,
      :addressee_custom => nil,
      :addressee_display => nil,
      :household_name => self.household_name,
      :created_date => self.created_at,
      :modified_date => self.updated_at
    )
  end
end
