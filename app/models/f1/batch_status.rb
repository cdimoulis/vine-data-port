# == Schema Information
#
# Table name: f1_batch_statuses
#
#  id   :integer          not null, primary key
#  uri  :string
#  name :string
#

class F1::BatchStatus < ActiveRecord::Base

  has_many :batches, class_name: F1::Batch.name

  def self.group
    'giving'
  end

  def self.base_route
    ''
  end

  def self.f1_attribute_map
    {

    }
  end

  def self.get_all_records(extra_route=nil, data=nil, max_pages=nil)
    puts "\n\nRecords for BatchStatus are saved when saving Batches\n\n"
    F1::Batch.all.to_a
  end

  # Total Records
  # 7/29/2017 3
end
