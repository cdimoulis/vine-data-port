class F1::Base < ActiveRecord::Base
  self.abstract_class = true

  def self.group
    nil
  end

  class << self
    # Find the attibutes listed in Fellowship one or local db
    # Force remote will force the list to come from Fellowship one
    def find_attributes(force_remote=false)
      if force_remote
        fetch_attributes()
      else
        begin
          column_names
        rescue
          fetch_attributes()
        end
      end
    end

    # Print them nicely
    def print_attributes(force_remote=false)
      find_attributes(force_remote).each do |a|
        puts "#{a}\n"
      end
    end

    # boolean uniq if only uniq records
    def pretty_pluck(uniq=false, *attrs)
      if uniq
        vals = self.pluck(*attrs).uniq()
      else
        vals = self.pluck(*attrs)
      end

      str = ''
      vals.each do |v|
        str += "#{v}\n"
      end
      puts str
    end

    # Show a specific record
    def show_record(id)
      get_response("/#{id}")
    end

    # Get all the records from Fellowshpi One
    def get_all_records(extra_route=nil, data=nil, max_pages=nil)
      # Rails.logger.warn "\nNo method to get all records implemented for: #{self.name}\n"
      records = []
      response = get_response(extra_route, data)
      records += get_response_records(response)
      page = get_page_data(response)
      if page.present?
        @total_records = page['@totalRecords'].to_i
        page_num = page['@pageNumber'].to_i
        rem_pages = page['@additionalPages'].to_i
        if max_pages.present? && page_num >= max_pages
          return records
        end
        if rem_pages != 0
          data[:page] = page_num + 1
          records += get_all_records(extra_route, data, max_pages)
        end
      else
        @total_records = records.length
      end
      records
    end

    def print_all_records(extra_route=nil, data=nil, max_pages=nil)
      records = get_all_records(extra_route, data, max_pages)
      str = "Count: #{records.length}\nTotal F1 Records: #{@total_records}\n\n"
      records.each do |r|
        str += "#{r}\n"
      end
      puts str
    end

    def store_all_records(extra_route=nil, data=nil, max_pages=nil, overwrite=false)
      if (self.count == 0) or overwrite
        # Clear out any exisitng records
        self.destroy_all
        records = get_all_records extra_route, data, max_pages
        records.each do |r|
          rr = replace_attributes format_keys replace_keys(r)
          if not self.exists?(rr['id'])
            n = self.new(rr)
            if not (n.valid? and n.save)
              puts "\n\nCould not save #{self.name} #{n.errrors.inspect}"
            end
          else
            puts "\n\n#{self.name} Already Exists: #{rr.inspect}\nData: #{data.inspect}\n\n"
          end
        end
      end
    end

    # Replace keys with f1_attribute_map
    # Nil means remove key
    def replace_keys(record)
      r = {}
      return record if !respond_to?(:f1_attribute_map)
      map = f1_attribute_map
      record.each do |k,v|
        # If the key is in the map
        if map.include?(k.to_sym)
          # Only if key is not nil
          if map[k.to_sym].present?
            r[map[k.to_sym]] = v
          end
        # Otherwise just keep the key
        else
          r[k] = v
        end
      end
      r
    end

    # Remove @ in keys and convert to underscore
    def format_keys(record)
      r = {}
      record.each do |k,v|
        r[k.sub('@','').underscore] = v
      end
      r
    end

    # To overwrite in child classes
    def replace_attributes(record, *args)
      record
    end

    protected

    def fetch_attributes(extra_route=nil, data=nil)
      pluck_attributes(get_response_records(get_response(extra_route, data)))
    end

    def get_response(extra_route=nil, data=nil)
      route = self.base_route
      if extra_route.present?
        route += extra_route
      end
      F1.get_data(route, '.json', self.group, data)
    end

    def get_page_data(response)
      return if response.nil?

      resource_name = self.name.split('::')[1]
      f1_name = resource_name[0,1].downcase + resource_name[1..-1]
      if response.include?('results')
        data = response['results'].dup
        data.delete(f1_name)
      end
      data
    end

    # Parse out only the records in the response
    def get_response_records(response)
      return [] if response.nil?
      # If Base is not superclass then get the superclass for the resource_name
      # Intereted classes are not Fellowship One tables, but their superclass is
      if superclass == F1::Base
        resource_name = self.name.split('::')[1]
      else
        resource_name = superclass.name.split('::')[1]
      end
      f1_name = resource_name[0,1].downcase + resource_name[1..-1]
      if response.include?(f1_name.pluralize) and response[f1_name.pluralize].present?
        if response[f1_name.pluralize].include?(f1_name)
          records = response[f1_name.pluralize][f1_name]
        else
          []
        end
      elsif response['results'].present?
        if response['results'].include?(f1_name)
          records = response['results'][f1_name]
        else
          []
        end
      else
        []
      end
    end

    def pluck_attributes(records)
      keys = []
      if records.present? and records.length > 0
        records.each do |r|
          keys += r.keys
        end
      end
      keys.uniq
    end
  end
end
