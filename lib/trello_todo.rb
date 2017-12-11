require 'trello_todo/version'
require 'trello_todo/cli'
require 'trello_todo/trello/member'
require 'yaml'
require 'active_record'

db_config = YAML.load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(db_config['development'])

unless File.exist?(db_config['development']['database'])
  ActiveRecord::Base.connection
  ActiveRecord::Migrator.migrate("db/migrate/")
  ActiveRecord::Base.establish_connection(db_config['development'])
  require 'active_record/schema_dumper'
  filename = "db/schema.rb"
  File.open(filename, "w:utf-8") do |file|
    ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
  end
end

module TrelloTodo
  def self.run(args)
    abort('Username is required') if args.empty?

    m = Member.create!(name: args[0])
    p m
    #    CLI.show_boards_of(member: m)
    #    print 'Please select a board: '
    #    i = $stdin.gets.chomp.to_i
    #    CLI::Util.clear_line(m.boards.size + 3)
    #    b = m.boards[i - 1]
    #    CLI.show_lists_of(board: b)
  end
end
