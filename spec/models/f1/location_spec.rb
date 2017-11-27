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

require 'rails_helper'

RSpec.describe F1::Location, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
