require 'trello_todo/http'
require 'trello_todo/trello_api/endpoint'

module TrelloTodo
  class Board

    attr_reader :id, :name

    def initialize(id:, name:)
      @id = id
      @name = name
      @lists = []
    end

    # Get all lists of the board
    def get_lists
      endpoint = "/1/boards/#{id}/lists?"
      url = TrelloTodo::TrelloAPI::Endpoint.base_url + endpoint + TrelloTodo::TrelloAPI::Endpoint.auth_url

      response = HTTP.get(url)
      @lists = response
    end
  end
end

