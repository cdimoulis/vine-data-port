# == Schema Information
#
# Table name: f1_batches
#
#  id              :integer          not null, primary key
#  uri             :string
#  old_id          :integer
#  name            :string
#  amount          :float
#  batch_type_id   :integer
#  batch_status_id :integer
#  batch_date      :datetime
#  received_date   :datetime
#  created_by_id   :integer
#  updated_by_id   :integer
#  created_at      :datetime
#  updated_at      :datetime
#

FactoryGirl.define do
  factory :f1_batch, class: 'F1::Batch' do
    
  end
end
