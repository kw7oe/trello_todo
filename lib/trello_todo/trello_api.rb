require 'trello_todo/store'
require 'trello_todo/trello_api/endpoint'
require 'trello_todo/board'
require 'trello_todo/http'

module TrelloTodo
  class TrelloAPI
    def initialize
      # Load user API key and Auth Tooken
      load_config

      # Declare base and auth url
      @base_url = Endpoint.base_url
      @auth_url = Endpoint.auth_url(
        api_key: @config.fetch('API_KEY'),
        auth_token: @config.fetch('AUTH_TOKEN'))

      # Get all the boards of the user
      @boards = get_boards_for(user: @config.fetch('username'))
    end

    # Get all the boards of a given user
    def get_boards_for(user:)
      endpoint = "/1/members/#{user}/boards?"
      url = @base_url + endpoint + @auth_url

      response = HTTP.get(url)
      response.map do |board|
        Board.new(id: board['id'], name: board['name'])
      end
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
      @config.fetch('username') {
        get_username
        Store.store_config(@config)
      }
    end

    def get_username
      print "Enter your Trello username here: "
      username = $stdin.gets.chomp
      @config['username'] = username
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
      auth_endpoint = 'https://trello.com/1/authorize?expiration=never&name=SinglePurposeToken&scope=read,write&response_type=token&key='
      request_url = auth_endpoint + @config['API_KEY']
      puts "Please visit this url to get authentication token."
      puts request_url
      print "Enter the token here: "
      token = $stdin.gets.chomp

      @config['AUTH_TOKEN'] = token
    end
  end
end

