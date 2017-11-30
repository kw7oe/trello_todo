require 'trello_todo//trello/checklist'

module TrelloTodo
  class Card
    attr_reader :id, :name

    def initialize(id:, name:, labels:)
      @id = id
      @name = name
      @labels = labels
      @checklists = []
    end

    def checklists
      return @checklists unless @checklists.empty?

      endpoint = "/1/cards/#{id}/checklists?"
      response = Client.get(endpoint)
      @checklists = response.map do |checklist|
        Checklist.new(id: checklist['id'], name: checklist['name'], items: checklist['checkItems'])
      end
    end

    def to_s
      "#{id}: #{name}"
    end
  end
end
