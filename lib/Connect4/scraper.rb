require 'Open-uri'
require 'Nokogiri'
require 'pry'
require_relative 'game.rb'
require_relative 'strategy.rb'

class Scraper
  attr_accessor :doc, :steps, :strat_object

  def wiki
    html = open('https://en.wikipedia.org/wiki/Connect_Four')
    doc = Nokogiri::HTML(html)
    puts doc.css('.templatequote p').text.strip
    puts ' '
  end

  def get_info(strat_object)
    html = open('https://www.wikihow.com/Win-at-Connect-4#Learning-Basic-Strategies_sub')
    doc = Nokogiri::HTML(html)
    doc.css('.hasimage').each do |li_tag|
      hash = {
        title: li_tag.css('div.step b').text,
        instruction: li_tag.css('div.step').text.split("\n")[1...-1].join(' ')
      }
      strat_object.add_step(hash)
    end
  end

  def play_again?
    print "\nPlay again?(play/back/exit):\n"
    q = gets.chomp!
    case q
    when 'play'
      print "\nWelcome to Connect Four! Player 1 will be X and Player 2 is O!\n"
      self.wiki
      Game.new
      play_again?
    when 'back'
      Play_Game.new
    when 'exit'
      puts 'Goodbye!'
      exit!
    end
  end

  def step_info(strat_object)
    q = nil
    strat_object.steps.each.with_index(1) do |hash, index|
      puts "#{index}. #{hash[:title]}"
    end
    puts "\nEnter the number of the Pro-tip you'd like to know more about, 'back' to go back to the list of tips or 'play' to practice."
    while q != 'exit'
      q = gets.strip.downcase
      end_num = strat_object.steps.size
      if (1..end_num).include?(q.to_i)
        index = q.to_i - 1
        hash = strat_object.steps[index]
        puts "#{hash[:instruction]}\n"
        puts "\nEnter the number of the Pro-tip you'd like to know more about, 'back' to go back to the list of tips or 'play' to practice."
      elsif q.to_s == 'back'
        objective = Scraper.new
        bob = Strategy.new("Learning Basic Strategies")
        objective.get_info(bob)
        objective.wiki
        objective.step_info(bob)
      elsif q.to_s == 'play'
        Game.new
        play_again?
      elsif 'exit'
        puts 'Goodbye!'
        exit!
      else
        puts "I don't understand. Type 'back' or 'play' please."
      end
    end
  end
end