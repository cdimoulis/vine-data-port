# == Schema Information
#
# Table name: f1_communications
#
#  id                         :integer          not null, primary key
#  uri                        :string
#  household_id               :integer
#  person_id                  :integer
#  communication_type_id      :integer
#  communication_general_type :string
#  communication_value        :string
#  search_communication_value :string
#  preferred                  :boolean
#  communication_comment      :text
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

FactoryGirl.define do
  factory :f1_communication, class: 'F1::Communication' do
    
  end
end
