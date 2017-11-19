require 'net/http'
require 'trello_todo/store'

module TrelloTodo
  class TrelloAPI
    def initialize
      load_config
      puts "Initalize complete"
    end

    private
    def load_config
      @config = Store.load_config
      @config.fetch('API_KEY') {
        get_api_key
        Store.store_config(@config)
      }
      @config.fetch('AUTH_TOKEN') {
        get_auth_token
        Store.store_config(@config)
      }
    end

    def get_api_key
      api_key_endpoint = 'https://trello.com/app-key'
      puts "Please login into Trello first and visit to this url to get your Developer API key."
      puts api_key_endpoint

      print "Enter the API key here: "
      api_key = $stdin.gets.chomp
      @config['API_KEY'] = api_key
    end

    def get_auth_token
      auth_endpoint = 'https://trello.com/1/authorize?expiration=never&name=SinglePurposeToken&key='
      request_url = auth_endpoint + @config['API_KEY']
      puts "Please visit this url to get authentication token."
      puts request_url
      print "Enter the token here: "
      token = $stdin.gets.chomp

      @config['AUTH_TOKEN'] = token
    end
  end
end

