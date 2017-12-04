module TrelloTodo
  module CLI
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

    module Util
      def self.title(input)
        "#{input}\n#{'-' * input.length}"
      end

      def self.clear_line(n)
       print "\e[2K\e[1A\e[1G" * (n) + "\e[2K" 
      end
    end
  end
end
