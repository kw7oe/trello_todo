module TrelloTodo
  class Store
    CONFIGURATION_FILE = Dir.home + '/.trello_todo'

    def self.store_config(config)
      File.open(CONFIGURATION_FILE, 'w') do |f|
        config.each do |k, v|
          f.puts "#{k}=#{v}"
        end
      end
    end

    def self.load_config
      return nil unless File.exist? CONFIGURATION_FILE
      File.readlines(CONFIGURATION_FILE).map do |line|
        key, value = line.chomp.split('=')
        [key, value]
      end.to_h
    end
  end
end
