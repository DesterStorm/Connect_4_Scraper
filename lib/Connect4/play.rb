require_relative 'game.rb'
require_relative 'scraper.rb'
require_relative 'strategy.rb'
class Play_Game
  objective = Scraper.new
  bob = Strategy.new("Learning Basic Strategies")
  objective.get_info(bob)
  objective.wiki
  objective.step_info(bob)
end


