class ALF::Base #< ActiveRecord::Base
  # -*- SkipSchemaAnnotations
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  # self.abstract_class = true

  def initialize(*args)
    if args[0].present?
      self.attributes.each do |a|
        val = args[0][a]
        val = args[0][a.to_s] if val.nil?
        if val.present?
          self.send("#{a}=",val)
        end
      end
    end
  end

  def attributes
    self.class.attributes
  end

  ####
  # Association Methods
  ####

  # Uses class method alf_belongs_to for associations
  # :association_name => {class: 'ALF::Classname',
  #                 through: 'attribute in model',
  #                 assoc_attribute: 'matching attribute in association'}
  # through is only needed if the attribute is different name than assocation
  # assoc_attribute is only needed if the value is different than the id_attribute
  def get_belongs_to(assoc)
    records = []
    # Association exists
    if self.class.alf_belongs_to.include?(assoc)
      # Belongs to hash
      bt = self.class.alf_belongs_to[assoc]
      # Association class
      assoc_class = bt[:class].constantize
      record_attr = bt[:through] || assoc
      alf_attr = bt[:assoc_attribute] || assoc_class.id_attribute || bt[:through]
      records = assoc_class._where alf_attr, self.send(record_attr)

      # Return first record since this is a belongs to
      assoc_class.new(records[0]);
    end
  end

  # Uses class method alf_has_many for associations
  # :association_name => {class: 'ALF::Classname',
  #                 foreign_key: 'attribute with id in association'}
  # foreign_key is only needed if the attribute in the association is different
  # than the id_attribute
  def get_has_many(assoc)
    records = []
    # Association exists
    if self.class.alf_has_many.include?(assoc)
      # Belongs to hash
      bt = self.class.alf_has_many[assoc]
      # Association class
      assoc_class = bt[:class].constantize
      record_attr = self.class.id_attribute || assoc
      alf_attr = bt[:foreign_key] || self.class.id_attribute || assoc
      records = assoc_class._where alf_attr, self.send(record_attr)
    end
    # Return first record since this is a belongs to
    records
  end


  #####
  # CLASS METHODS
  #####

  class << self

    def id_attribute
      'id'
    end

    #####
    # API REQUEST METHODS
    #####

    def get_attributes
      data = {limit: 10}
      rs = _get_records nil, data
      pluck_attributes rs
    end

    # Get the records for a single request
    def _get_records(path=nil, data=nil)
      alf_name = self.alf_name
      if alf_name.nil?
        alf_name = self.name.split('::')[1].underscore
      end
      records = AlfAPI::Connection.get alf_name, path, data
      records
    end

    # Get records for a single reqeust as models
    def get_records(path=nil, data=nil)
      records = []
      _get_records(path, data).each do |r|
        records.push self.new(r)
      end
      records
    end

    # Page through all the records on a request.
    def _get_all_records(path=nil, data=nil)
      data ||= {}
      data = {limit: 1000}.merge data
      rs = _get_records nil, data
      # puts "\n\nPage records: #{rs.length}\noffset: 0\n"
      # puts "First: #{rs[0]['person_id']}\n\n"
      records = rs
      # Set offset
      data[:offset] = 0
      while !(rs.length < data[:limit])
        data[:offset] += 1
        rs = _get_records path, data
        # puts "\n\nPage records: #{rs.length}\noffset: #{data[:offset]}\n"
        # puts "First: #{rs[0]['person_id']}\n\n"
        records += rs
      end
      records
    end

    # Get ALL records as models
    def get_all_records(path=nil, data=nil)
      records = []
      _get_all_records(path, data).each do |r|
        records.push self.new(r)
      end
      records
    end

    # Pretty print all the records received
    def print_all_records(path=nil, data=nil)
      records = _get_all_records path, data
      str = "Total: #{records.length}\n\n"
      records.each do |r|
        str += "#{r}\n"
      end
      puts str
    end

    # Query the database for a particular attribute (attr) of value (val)
    def _where(attr, val, path=nil, data=nil)
      records = []
      data ||= {}
      if attr.present? and val.present?
        data = data.merge({id: attr, id_value: val})
        records = _get_all_records(path, data)
      end
      records
    end

    # Where but you get the models
    def where(attr, val, path=nil, data=nil)
      records = []
      _where(attr, val, path, data).each do |r|
        records.push self.new(r)
      end
      records
    end

    # Pretty print the query the database for a particular attribute (attr)
    # of value (val)
    def print_where(attr, val, path=nil, data=nil)
      records = _where attr, val, path, data
      str = "Total: #{records.length}\n\n"
      records.each do |r|
        str += "#{r}\n"
      end
      puts str
    end

    #####
    # OVERRIDES
    #####

    def attr_accessor(*vars)
      @attributes ||= []
      @attributes.concat vars
      super(*vars)
    end

    def attributes
      @attributes
    end

    #####
    # END OVERRIDES
    #####

    protected

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

  #####
  # END CLASS METHODS
  #####
end
