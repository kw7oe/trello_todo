require 'trello_todo/client'
require 'trello_todo/list'

module TrelloTodo
  class Board
    attr_reader :id, :name

    def initialize(id:, name:)
      @id = id
      @name = name
      @lists = []
      @checklists = []
    end

    # Get all lists of the board
    def lists
      return @lists unless @lists.empty?

      endpoint = "/1/boards/#{id}/lists?"
      response = Client.get(endpoint)
      @lists = response.map do |list|
        List.new(id: list['id'], name: list['name'])
      end
    end

    def to_s
      "#{id}: #{name}"
    end

  end
end
