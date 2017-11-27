module FellowshipOneAPI
  # From f1.yml
  class Configuration
    class << self

      # Explictly defines where the configuration file is
      def file_path=(path)
        @config_yaml = nil
        @file_path = path
      end

      # Gets the specified key from the configuration file
      # [Example]    FellowshipTechAPIClient.Configuration["consumer_key"] <i># "2"</i>
      #
      #              FellowshipTechAPIClient.Configuration["consumer_secret"] <i># "12345678-9abc-def0-1234-567890abcdef"</i>
      def [](value)
        load_yaml if @config_yaml.nil?
        val = @config_yaml[value]
        # if we have the string has "{church_code}" then we'll substitute it
        if val =~ /\{church_code\}/ and value != "church_code"
          return val.gsub("{church_code}", self["church_code"])
        end
        return val
      end

      # Overridden method_missing to facilitate a more pleasing ruby-like syntax for accessing
      # configuration values
      def method_missing(name, *args, &block)
        return self[name.to_s] unless self[name.to_s].nil?
        super
      end
      

      private

      # Loads the YAML file
      #
      # Starts by looking to see if file_path is defined then checks in current directory (.) and then your Rails.root and then the config
      # directory off of the base directory of the gem
      def load_yaml
        begin
          if not @file_path.nil?
            @config_yaml = YAML.load_file(@file_path)
          elsif File.exists? "./f1.yml"
            @config_yaml = YAML.load_file("./f1.yml")
          elsif defined? ::Rails
            @config_yaml = YAML.load_file("#{::Rails.root.to_s}/config/f1.yml")
          else
            path = File.dirname(__FILE__) + "/../../config/f1.yml"
            @config_yaml = YAML.load_file(path)
          end
          true
        rescue Exception => ex
          puts "There was an error: #{ex.message}"
          false
        end
      end

    end
  end
end
