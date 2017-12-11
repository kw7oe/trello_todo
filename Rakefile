require 'bundler/gem_tasks'
require 'yaml'
require 'active_record'

task default: :spec

namespace :db do
  db_config = YAML::load(File.open('config/database.yml'))

  desc "Create the database"
  task :create do
    ActiveRecord::Base.establish_connection(db_config['development'])
    ActiveRecord::Base.connection
    puts "Database created. Database file located at #{db_config['development']['database']}."
  end

  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.establish_connection(db_config['development'])
    ActiveRecord::Migrator.migrate("db/migrate/")
    Rake::Task["db:schema"].invoke
    puts "Database migrated."
  end
    

  desc "Drop the database"
  task :drop do
    `rm #{db_config['development']['database']}`
    puts "Database deleted."
  end

  task :schema do 
    ActiveRecord::Base.establish_connection(db_config['development'])
    require 'active_record/schema_dumper'
    filename = "db/schema.rb"
    File.open(filename, "w:utf-8") do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
  end

end
