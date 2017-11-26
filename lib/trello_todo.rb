require 'trello_todo/version'
require 'trello_todo/member'

module TrelloTodo
  def self.run(args)
    m = Member.new(username: args[0])
    b = m.boards[6]
    puts b
    l = b.lists[2]
    puts l
    c = l.cards[0]
    puts c
    ci = c.checklists[0]
    puts ci
    items = ci.items
    puts items
  end
end
