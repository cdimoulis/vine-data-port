# == Schema Information
#
# Table name: f1_batch_types
#
#  id   :integer          not null, primary key
#  uri  :string
#  name :string
#

class F1::BatchType < F1::Base

  has_many :batches, class_name: F1::Batch.name

  def self.group
    'giving'
  end

  def self.base_route
    '/batches/batchtypes'
  end

  def self.f1_attribute_map
    {

    }
  end

  # Total Records
  # 7/29/2017 4
end
