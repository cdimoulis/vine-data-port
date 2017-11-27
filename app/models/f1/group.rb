# == Schema Information
#
# Table name: f1_groups
#
#  id                   :integer          not null, primary key
#  uri                  :string
#  name                 :string
#  description          :text
#  start_date           :datetime
#  expiration_date      :datetime
#  is_open              :boolean
#  is_public            :boolean
#  has_childcare        :boolean
#  is_searchable        :boolean
#  campus_id            :integer
#  group_type_id        :integer
#  group_url            :string
#  timezone_id          :integer
#  gender_id            :integer
#  marital_status_id    :integer
#  start_age_range      :string
#  end_age_range        :string
#  date_range_type_id   :integer
#  leaders_count        :string
#  members_count        :string
#  open_prospects_count :string
#  event_id             :integer
#  location_id          :integer
#  is_location_private  :boolean
#  created_by_id        :integer
#  updated_by_id        :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class F1::Group < F1::Base

  belongs_to :campus, class_name: F1::Campus.name
  belongs_to :gender, class_name: F1::Gender.name
  belongs_to :group_type, class_name: F1::GroupType.name
  belongs_to :date_range_type, class_name: F1::DateRangeType.name
  belongs_to :timezone, class_name: F1::Timezone.name
  belongs_to :marital_status, class_name: F1::MaritalStatus.name
  belongs_to :event, class_name: F1::Event.name
  belongs_to :location, class_name: F1::Location.name

  has_many :categories_groups, class_name: F1::CategoriesGroup.name, dependent: :destroy
  has_many :categories, class_name: F1::Category.name, through: :categories_groups

  def self.group
    'groups'
  end

  def self.base_route
    '/groups'
  end

  def self.f1_attribute_map
    {
      churchCampus: 'campus_id',
      timeZone: 'timezone_id',
      gender: 'gender_id',
      groupType: 'group_type_id',
      dateRangeType: 'date_range_type_id',
      maritalStatus: 'marital_status_id',
      event: 'event_id',
      location: 'location_id',
      createdByPerson: 'created_by_id',
      lastUpdatedByPerson: 'updated_by_id',
      createdDate: 'created_at',
      lastUpdatedDate: 'updated_at'
    }
  end

  def self.find_attributes(force_remote=false)
    if force_remote
      fetch_attributes('/search', {isSearchable: 'true'})
    else
      begin
        column_names
      rescue
        fetch_attributes('/search', {isSearchable: 'true'})
      end
    end
  end

  def self.get_all_records(extra_route=nil, data=nil, max_pages=nil)
    data = data || {}
    records = []
    F1::Category.all.each do |category|
      rs = super "/search", {categoryID: category.id, recordsPerPage: 2000}.merge(data), max_pages
      rs.each do |r|
        r['category_id'] = category.id
      end
      records += rs
    end
    @total_records = records.length
    records
  end

  def self.store_all_records(extra_route=nil, data=nil, max_pages=nil, overwrite=false)
    if (F1::Group.count == 0) or overwrite
      F1::Group.destroy_all
      F1::CategoriesGroup.destroy_all
      records = get_all_records extra_route, data, max_pages
      records.each do |r|
        rr = replace_attributes format_keys replace_keys(r)
        # Get the category_id
        category_id = rr['category_id']
        # remove the category_id from hash
        rr = rr.except('category_id')
        # Create group if it doesn't exist
        if not F1::Group.exists?(rr['id'])
          g = F1::Group.new(rr)
          if g.valid? and g.save
            # Create join with category
            c = F1::CategoriesGroup.new(
              category_id: category_id,
              group_id: g.id
            )
            if not (c.valid? and c.save)
              puts "\n\nCould not save CategoriesGroup #{c.errrors.inspect}\n\n"
            end
          else
            puts "\n\nCould not save Group #{g.errrors.inspect}\n\n"
          end
        else
          # Save join with category even though group exists
          c = F1::CategoriesGroup.new(
            category_id: category_id,
            group_id: rr['id']
          )
          if not (c.valid? and c.save)
            puts "\n\nCould not save CategoriesGroup #{c.errrors.inspect}\n\n"
          end
        end
      end
    end
  end

  # Total Records
  # 7/27/2017  771 (1,574 fetched using categories)

  def self.replace_attributes(record, *args)
    record['campus_id'] = record['campus_id']['@id']
    record['timezone_id'] = record['timezone_id']['@id']
    record['gender_id'] = record['gender_id']['@id']
    record['group_type_id'] = record['group_type_id']['@id']
    record['date_range_type_id'] = record['date_range_type_id']['@id']
    record['marital_status_id'] = record['marital_status_id']['@id']
    record['event_id'] = record['event_id']['@id']
    record['location_id'] = record['location_id']['@id']
    record['created_by_id'] = record['created_by_id']['@id']
    record['updated_by_id'] = record['updated_by_id']['@id']

    record
  end
end
