# == Schema Information
#
# Table name: f1_group_types
#
#  id             :integer          not null, primary key
#  name           :string
#  uri            :string
#  description    :string
#  is_web_enabled :boolean
#  is_searchable  :boolean
#  created_by_id  :integer
#  updated_by_id  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe F1::GroupType, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
