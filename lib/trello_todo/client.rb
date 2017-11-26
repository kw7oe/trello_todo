require 'net/http'
require 'json'
require 'trello_todo/config'

module TrelloTodo
  module Client
    class << self
      @auth_url = nil

      def get(path)
        base_url = 'https://api.trello.com'
        url = base_url + path + auth_url

        uri = URI(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(uri)
        response = http.request request

        JSON.parse(response.read_body)
      end

      def auth_url
        @auth_url if @auth_url
        @auth_url = "key=#{Config.api_key}&token=#{Config.auth_token}"
      end
    end
  end
end
