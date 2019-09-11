require_relative 'scraper.rb'


class Game
  attr_reader :current_turn, :board, :game_over

  # starts with the first player as X
  # outputs the board with rows (x) and columns (y)
  # sets game_over to false to not immediately end the game
  # runs show_board
  def initialize
    @current_turn = 'X'
    # array of arrays of strings separated by spaces i/o commas
    @board = [
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[1 2 3 4 5 6 7]
    ]
    # game_over is set to false or game would end on initialize
    @game_over = false

    show_board
    play
  end

  # switches the current_turn variable to player 2, and the
  # second player places a piece on the board.
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

  # asks the user to pick a column on the board where they
  # would like to drop their piece and scrapes
  # https://www.wikihow.com/Win-at-Connect-4
  # to print a tip depending on the column chosen.
  def place_piece
    puts "\npick a column from 1-7 to drop your piece #{current_turn}.\nEach column gives a unique tip!"
    column = gets.chomp.to_i
    check_move?(column)
    lesson = Scraper.new
    if column == 1
      lesson.step4
    elsif column == 2
      lesson.step2
    elsif column == 3
      lesson.step3
    elsif column == 4
      lesson.step1
    elsif column == 5
      lesson.step5
    elsif column == 6
      lesson.step6
    elsif column == 7
      lesson.step7
    end
  end

  # combine each board string with a space
  def show_board
    @board.each do |row|
      puts ' ' + row.join(' ')
    end
  end

  # validates that their response is on the board, and places
  # their move appropriately.
  def check_move?(move)
    # if move between 1 and 7 and   the first row is empty
    if move.between?(1, 7) && @board[0][move - 1] == '_'
      true
      # puts piece in the row above the numbers
      index = 6
      # when the index is not open, subtract 1 from index to place piece 1 row up
      while @board[index][move - 1] != '_'
        index -= 1
      end
      # current turn changes after placing a valid piece
      @board[index][move - 1] = @current_turn
    else
      puts 'Invalid move, try again'
      !change_turn
    end
  end

  # checks if a player has 4 pieces in a row
  def check_for_winner
    (0..5).each do |x|
      (0..6).each do |y|
        # horizontal
        if @board[x][y] == @current_turn &&
           @board[x][y + 1] == @current_turn &&
           @board[x][y + 2] == @current_turn &&
           @board[x][y + 3] == @current_turn
          puts "#{current_turn} wins!"
          # game_over is set to true, the play loop ends, and a message is
          # sent to the screen congratulating the winner and asking to play again.
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


