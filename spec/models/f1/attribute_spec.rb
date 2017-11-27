# == Schema Information
#
# Table name: f1_attributes
#
#  id                 :integer          not null, primary key
#  uri                :string
#  old_id             :integer
#  name               :string
#  attribute_group_id :integer
#

require 'rails_helper'

RSpec.describe F1::Attribute, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
