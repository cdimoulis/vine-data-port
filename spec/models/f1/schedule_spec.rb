# == Schema Information
#
# Table name: f1_schedules
#
#  id                 :integer          not null, primary key
#  uri                :string
#  name               :string
#  description        :text
#  start_time         :datetime
#  end_time           :datetime
#  number_recurrences :integer
#  start_date         :date
#  end_date           :date
#  recurrence_type_id :integer
#  recurrences        :json
#  event_id           :integer
#  created_by_id      :integer
#  updated_by_id      :integer
#  created_at         :datetime
#  updated_at         :datetime
#

require 'rails_helper'

RSpec.describe F1::Schedule, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
