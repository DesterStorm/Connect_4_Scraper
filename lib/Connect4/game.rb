require_relative 'scraper.rb'


class Game
  attr_reader :current_turn, :board, :game_over

  def initialize
    print "\n Welcome to Connect Four! Player 1 will be X and Player 2 is O!\n\n"
    @current_turn = 'X'
    @board = [
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[1 2 3 4 5 6 7]
    ]
    @game_over = false
    show_board
    play
  end

  def change_turn
    @current_turn = @current_turn == 'X' ? 'O' : 'X'
  end

  def play
    until @game_over
      place_piece
      check_for_winner
      change_turn
      show_board
    end
  end

  def place_piece
    puts "\npick a column from 1-7 to drop your piece #{current_turn}.\nEach column gives a unique tip!"
    column = gets.chomp.to_i
    check_move?(column)
  end

  def show_board
    @board.each do |row|
      puts ' ' + row.join(' ')
    end
  end

  def check_move?(move)
    if move.between?(1, 7) && @board[0][move - 1] == '_'
      true
      index = 6
      while @board[index][move - 1] != '_'
        index -= 1
      end
      @board[index][move - 1] = @current_turn
    else
      puts 'Invalid move, try again'
      !change_turn
    end
  end

  def check_for_winner
    (0..5).each do |x|
      (0..6).each do |y|
        # horizontal
        if @board[x][y] == @current_turn &&
           @board[x][y + 1] == @current_turn &&
           @board[x][y + 2] == @current_turn &&
           @board[x][y + 3] == @current_turn
           puts "#{current_turn} wins!"
           @game_over = true
        end
        # vertical
        if @board[x][y] == @current_turn &&
           @board[x + 1][y] == @current_turn &&
           @board[x + 2][y] == @current_turn &&
           @board[x + 3][y] == @current_turn
           puts "#{current_turn} wins!"
           @game_over = true
        end
        # diagonal left
        if @board[x][y] == @current_turn &&
           @board[x + 1][y - 1] == @current_turn &&
           @board[x + 2][y - 2] == @current_turn &&
           @board[x + 3][y - 3] == @current_turn
           puts "#{current_turn} wins!"
           @game_over = true
        end
        # diagonal right
        if @board[x][y] == @current_turn &&
           @board[x + 1][y + 1] == @current_turn &&
           @board[x + 2][y + 2] == @current_turn &&
           @board[x + 3][y + 3] == @current_turn
           puts "#{current_turn} wins!"
           @game_over = true
        end
      end
    end
  end
end


