require 'trello_todo/trello/card'

module TrelloTodo
  class List
    attr_reader :id, :name

    def initialize(id:, name:)
      @id = id
      @name = name
      @cards = []
    end

    def cards
      return @cards unless @cards.empty?

      endpoint = "/1/lists/#{id}/cards?"
      response = Client.get(endpoint)
      @cards = response.map do |card|
        Card.new(id: card['id'], name: card['name'], labels: card['labels'])
      end
    end

    def to_s
      "#{id}: #{name}"
    end
  end
end
