# == Schema Information
#
# Table name: f1_timezones
#
#  id   :integer          not null, primary key
#  name :string
#  uri  :string
#

FactoryGirl.define do
  factory :f1_timezone, class: 'F1::Timezone' do
    
  end
end
