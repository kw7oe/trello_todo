module TrelloTodo
  class CheckItem
    attr_reader :id, :name, :state

    def initialize(id:, name:, state:)
      @id = id
      @name = name
      @state = state
    end

    def to_s
      "#{name}: #{state}"
    end
  end
end
