require 'trello_todo/trello/board'

module TrelloTodo
  class Member
    attr_reader :username

    def initialize(username:)
      @username = username
      @boards = []
    end

    # Get all the boards of a given user
    def boards
      return @boards unless @boards.empty?

      endpoint = "/1/members/#{username}/boards?"
      response = Client.get(endpoint)

      @boards = response.map do |board|
        Board.new(id: board['id'], name: board['name'])
      end
    end

    def to_s
      username
    end
  end
end
