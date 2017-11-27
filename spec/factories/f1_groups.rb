# == Schema Information
#
# Table name: f1_groups
#
#  id                   :integer          not null, primary key
#  uri                  :string
#  name                 :string
#  description          :text
#  start_date           :datetime
#  expiration_date      :datetime
#  is_open              :boolean
#  is_public            :boolean
#  has_childcare        :boolean
#  is_searchable        :boolean
#  campus_id            :integer
#  group_type_id        :integer
#  group_url            :string
#  timezone_id          :integer
#  gender_id            :integer
#  marital_status_id    :integer
#  start_age_range      :string
#  end_age_range        :string
#  date_range_type_id   :integer
#  leaders_count        :string
#  members_count        :string
#  open_prospects_count :string
#  event_id             :integer
#  location_id          :integer
#  is_location_private  :boolean
#  created_by_id        :integer
#  updated_by_id        :integer
#  created_at           :datetime
#  updated_at           :datetime
#

FactoryGirl.define do
  factory :f1_group, class: 'F1::Group' do
    
  end
end
