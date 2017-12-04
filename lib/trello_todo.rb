require 'trello_todo/version'
require 'trello_todo/cli'
require 'trello_todo/trello/member'

module TrelloTodo
  def self.run(args)
    abort('Username is required') if args.empty?
    m = Member.new(username: args[0])
    CLI.show_boards_of(member: m)
    print 'Please select a board: '
    i = $stdin.gets.chomp.to_i
    CLI::Util.clear_line(m.boards.size + 3)
    b = m.boards[i - 1]
    CLI.show_lists_of(board: b)
  end
end
