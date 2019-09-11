require_relative 'game.rb'
require_relative 'scraper.rb'

class Play_Game

  print "\n Welcome to Connect Four! Player 1 will be X and Player 2 is O!\n\n "

  # scrape the game objective from wikipedia.com
  objective = Scraper.new
  objective.wiki
  objective.call

  # start the game
  Game.new
  def play_again?
    print "\nPlay again?(yes/back/close): "
    q = gets.chomp
    q
    case q
    when q == "yes"
      print "\n Welcome to Connect Four! Player 1 will be X and Player 2 is O!\n\n "
      self.wiki
      Game.new
    when q == "back"
      play_game
    when q == "close"
      puts "Goodbye!"
      exit!
    end
  end

  play_again?
end

Play_Game.new

