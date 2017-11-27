# == Schema Information
#
# Table name: f1_communication_types
#
#  id           :integer          not null, primary key
#  uri          :string
#  general_type :string
#  name         :string
#

require 'rails_helper'

RSpec.describe F1::CommunicationType, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
