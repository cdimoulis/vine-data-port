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

require 'rails_helper'

RSpec.describe F1::Batch, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
