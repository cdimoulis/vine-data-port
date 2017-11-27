# == Schema Information
#
# Table name: f1_contribution_sub_types
#
#  id                   :integer          not null, primary key
#  uri                  :string
#  name                 :string
#  contribution_type_id :integer
#

require 'rails_helper'

RSpec.describe F1::ContributionSubType, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
