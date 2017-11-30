require 'trello_todo/trello/check_item'

module TrelloTodo
  class Checklist
    attr_reader :id, :name, :items

    def initialize(id:, name:, items:)
      @id = id
      @name = name
      @items = items.map do |item|
        CheckItem.new(id: item['id'], name: item['name'], state: item['state'])
      end
    end

    def to_s
      "#{id}: #{name}"
    end
  end
end
