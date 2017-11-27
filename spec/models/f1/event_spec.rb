# == Schema Information
#
# Table name: f1_events
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

require 'rails_helper'

RSpec.describe F1::Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
