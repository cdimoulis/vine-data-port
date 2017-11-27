# == Schema Information
#
# Table name: f1_group_types
#
#  id             :integer          not null, primary key
#  name           :string
#  uri            :string
#  description    :string
#  is_web_enabled :boolean
#  is_searchable  :boolean
#  created_by_id  :integer
#  updated_by_id  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :f1_group_type, class: 'F1::GroupType' do
    
  end
end
