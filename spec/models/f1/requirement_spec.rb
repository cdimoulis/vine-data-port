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

require 'rails_helper'

RSpec.describe F1::Requirement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
