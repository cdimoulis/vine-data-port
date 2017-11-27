# == Schema Information
#
# Table name: f1_requirements
#
#  id                  :integer          not null, primary key
#  uri                 :string
#  old_id              :string
#  name                :string
#  is_active           :boolean
#  has_document        :boolean
#  is_confidential     :boolean
#  is_background_check :boolean
#  is_reference_check  :boolean
#  quantity            :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :f1_requirement, class: 'F1::Requirement' do
    
  end
end
