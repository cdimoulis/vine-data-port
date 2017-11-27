module F1
  # $LOAD_PATH.unshift File.dirname(__FILE__)
  def self.table_name_prefix
    'f1_'
  end

  # Pre load these classes
  require 'f1/address_type'
  require 'f1/address'
  require 'f1/attribute_group'
  require 'f1/attribute'
  require 'f1/background_check_status'
  require 'f1/base'
  require 'f1/batch'
  require 'f1/batch_type'
  require 'f1/batch_status'
  require 'f1/campus'
  require 'f1/categories_group'
  require 'f1/category'
  require 'f1/communication'
  require 'f1/communication_type'
  require 'f1/contribution_receipt'
  require 'f1/contribution_sub_type'
  require 'f1/contribution_type'
  require 'f1/date_range_type'
  require 'f1/denomination'
  require 'f1/event'
  require 'f1/fund'
  require 'f1/fund_type'
  require 'f1/gender'
  require 'f1/group'
  require 'f1/group_type'
  require 'f1/household_member_type'
  require 'f1/household'
  require 'f1/location'
  require 'f1/marital_status'
  require 'f1/member_type'
  require 'f1/occupation'
  require 'f1/people_requirement'
  require 'f1/person'
  require 'f1/recurrence_type'
  require 'f1/requirement'
  require 'f1/requirement_status'
  require 'f1/schedule'
  require 'f1/school'
  require 'f1/status'
  require 'f1/sub_fund'
  require 'f1/sub_status'
  require 'f1/timezone'

  def self.get_data(route, type='.json', group=nil, data=nil)
      path = route+type
      query = ''
      if data.present?
        data.each do |atr,val|
          query += "#{atr}=#{val}&"
        end
        path += '?'+query
      end
      response = FellowshipOneAPI::Connection.request(:get, path, group)
      if response.present?
        JSON.parse(response.body)
      else
        raise "Invalid response #{response.code.to_i}\n#{response.inspect}"
      end
  end
end
