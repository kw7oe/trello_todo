require 'trello_todo/store'

module TrelloTodo
  class Config
    class << self
      @@config = Store.load_config

      @@config.each do |key, _value|
        define_method(key.downcase) do
          @@config.fetch(key) do
            send("get_#{key.downcase}")
            Store.store_config(@@config)
          end
        end
      end

      private

      def get_username
        print 'Enter your Trello username here: '
        username = $stdin.gets.chomp
        @@config['username'] = username
      end

      def get_api_key
        api_key_endpoint = 'https://trello.com/app-key'
        puts 'Please login into Trello first and visit to this url to get your Developer API key.'
        puts api_key_endpoint

        print 'Enter the API key here: '
        api_key = $stdin.gets.chomp
        @@config['API_KEY'] = api_key
      end

      def get_auth_token
        auth_endpoint = 'https://trello.com/1/authorize?expiration=never&name=SinglePurposeToken&scope=read,write&response_type=token&key='
        request_url = auth_endpoint + @@config['API_KEY']
        puts 'Please visit this url to get authentication token.'
        puts request_url
        print 'Enter the token here: '
        token = $stdin.gets.chomp

        @@config['AUTH_TOKEN'] = token
      end
    end
  end
end
