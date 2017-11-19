require 'trello_todo/version'
require 'trello_todo/trello_api'

module TrelloTodo

  def self.run(args)
    TrelloAPI.new()
  end

end
