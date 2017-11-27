namespace :info do
  task counts: :environment do
    models = F1.constants.select {|c| F1.const_get(c).is_a? Class}
    models.sort.each do |model|
      name = "F1::#{model}"
      cls = name.constantize
      if !cls.abstract_class
        puts "#{name} #{cls.count}\n"
      end
    end
  end
end
