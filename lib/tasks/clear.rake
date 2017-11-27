namespace :clear do
  task people: :environment do
    models = F1.constants.select {|c| F1.const_get(c).is_a? Class}
    models.each do |model|
      name = "F1::#{model}"
      cls = name.constantize
      if !cls.abstract_class
        puts "Clearing #{name} count: #{cls.count}\n"
        cls.destroy_all
        puts "Done clearing #{name} count: #{cls.count}\n"
      end
    end
  end
end
