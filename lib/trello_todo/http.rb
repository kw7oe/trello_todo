require 'net/http'
require 'json'

module TrelloTodo
  class HTTP

    def self.get(url)
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri)
      response = http.request request

      JSON.parse(response.read_body)
    end
  end
end