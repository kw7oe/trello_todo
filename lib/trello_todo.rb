require 'trello_todo/version'
require 'trello_todo/trello/member'

module TrelloTodo
  def self.run(args)
    m = Member.new(username: args[0])
    show_boards_of(member: m)
    print 'Please select a board: '
    i = $stdin.gets.chomp.to_i
    b = m.boards[i - 1]
    show_lists_of(board: b)
  end

  def self.show_boards_of(member:)
    puts Util.title 'Boards'
    member.boards.each_with_index do |b, index|
      puts "#{index + 1}: #{b.name}"
    end
  end

  def self.show_lists_of(board:)
    puts Util.title 'Lists'
    board.lists.each_with_index do |l, index|
      puts "#{index + 1}: #{l.name}"
    end
  end

  def self.show_cards_of(list:)
    p list.cards
  end

  def self.show_checklists_of(card:)
    p card.checklists
  end

  def self.show_items_of(checklist:)
    p checklist.items
  end

  class Util
    def self.title(input)
      "#{input}\n#{'-' * input.length}"
    end
  end
end
