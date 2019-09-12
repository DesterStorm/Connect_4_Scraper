class Strategy
  attr_accessor :strat_object
  attr_reader :title, :steps

  def initialize(title)
    @steps = []
    @title = title
  end

  def add_step(step)
    @steps << step
  end
end
