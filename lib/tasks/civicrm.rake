namespace :civicrm do
  namespace :db do |ns|

    task :migrate do
      Rake::Task["db:migrate"].invoke
    end

    task :rollback do
      Rake::Task['db:rollback'].invoke
    end

    namespace :schema do
      task :load do
        Rake::Task['db:schema:load'].invoke
      end

      task :dump do
        Rake::Task['db:schema:dump'].invoke
      end
    end

    ns.tasks.each do |task|
      task.enhance ['civicrm:set_custom_config'] do
        Rake::Task['civicrm:revert_to_original_config'].invoke
      end
    end
  end

  task :set_custom_config do
    # save current vars
    @original_config = {
      env_schema: ENV['SCHEMA'],
      config: Rails.application.config.dup
    }

    # set config variables for custom database
    ENV['SCHEMA'] = 'db_civicrm/schema.rb'
    Rails.application.config.paths['db'] = ['db_civicrm']
    Rails.application.config.paths['db/migrate'] = ['db_civicrm/migrate']
    Rails.application.config.paths['config/database'] = ["config/database_civicrm.yml"]
  end

  task :revert_to_original_config do
    # reset config variables to original
    ENV['SCHEMA'] = @original_config[':env_schema']
    Rails.application.config = @original_config[:config]
  end
end
