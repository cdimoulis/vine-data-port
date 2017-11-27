# == Schema Information
#
# Table name: f1_locations
#
#  id            :integer          not null, primary key
#  uri           :string
#  name          :string
#  description   :string
#  event_id      :integer
#  is_online     :boolean
#  url           :string
#  address       :json
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :f1_location, class: 'F1::Location' do
    
  end
end
