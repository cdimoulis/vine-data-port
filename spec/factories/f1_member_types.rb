# == Schema Information
#
# Table name: f1_member_types
#
#  id            :integer          not null, primary key
#  uri           :string
#  name          :string
#  description   :text
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

FactoryGirl.define do
  factory :f1_member_type, class: 'F1::MemberType' do
    
  end
end
