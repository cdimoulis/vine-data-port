# == Schema Information
#
# Table name: f1_batches
#
#  id              :integer          not null, primary key
#  uri             :string
#  old_id          :integer
#  name            :string
#  amount          :float
#  batch_type_id   :integer
#  batch_status_id :integer
#  batch_date      :datetime
#  received_date   :datetime
#  created_by_id   :integer
#  updated_by_id   :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class F1::Batch < F1::Base

  belongs_to :batch_type, class_name: F1::BatchType.name
  belongs_to :batch_status, class_name: F1::BatchStatus.name

  def self.group
    'giving'
  end

  def self.base_route
    '/batches'
  end

  def self.f1_attribute_map
    {
      batchType: 'batch_type_id',
      batchStatus: 'batch_status_id',
      createdByPerson: 'created_by_id',
      lastUpdatedByPerson: 'updated_by_id',
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  def self.find_attributes(force_remote=false)
    b = F1::BatchType.first
    if force_remote
      fetch_attributes('/search', {batchTypeID: b.id})
    else
      begin
        column_names
      rescue
        fetch_attributes('/search', {batchTypeID: b.id})
      end
    end
  end

  def self.get_all_records(extra_route=nil, data=nil, max_pages=nil)
    data = data || {}
    records = []
    local_total_records = 0
    F1::BatchType.all.each do |batch_type|
      rs = super "/search", {batchTypeID: batch_type.id, lastupdatedDate: '1975-01-01', recordsPerPage: 2000}.merge(data), max_pages
      local_total_records += @total_records
      rs.each do |r|
        r['batch_type_id'] = batch_type.id
      end
      records += rs
    end
    @total_records = local_total_records
    records
  end

  # Total Records
  # 7/27/2017  2383

  # Also creates all batch status records
  def self.replace_attributes(record, *args)
    if record['batch_status_id']['@id'].present?
      b = F1::BatchStatus.new(
        id: record['batch_status_id']['@id'],
        uri: record['batch_status_id']['@uri'],
        name: record['batch_status_id']['name']
      )
      if !F1::BatchStatus.exists?(b.id)
        if !(b.valid? and b.save)
          puts "\nCould not save BatchStatus #{b.errors.inspect}\n"
        end
      end
    end
    record['batch_status_id'] = record['batch_status_id']['@id']
    record['created_by_id'] = record['created_by_id']['@id']
    record['updated_by_id'] = record['updated_by_id']['@id']
    record
  end
end
