# frozen_string_literal: true

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
    print "\nPlay again?(play/back): \n"
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

  # asks the user which tip they'd like more info on
  def step_info(strat_object)
    q = nil
    strat_object.steps.each.with_index(1) do |hash, index|
      puts "#{index}. #{hash[:title]}"
    end
    puts "\n Enter the number of the Pro-tip you'd like to know more about, 'back' to go back to the list of tips or 'play' to practice."
    while q != 'exit'
      q = gets.strip.downcase
      end_num = strat_object.steps.size
      if (1..end_num).include?(q.to_i)
        index = q.to_i - 1
        hash = strat_object.steps[index]
        puts "#{hash[:instruction]}"
      elsif q == 'back'
        bob = Strategy.new("Learning Basic Strategies")
        Scraper.new.get_info(bob)
      elsif q == 'play'
        Game.new
        play_again?
      else
        puts "I don't understand. Type 'back' or 'play' please."
      end
    end
  end
  end

# test = Scraper.new
# test.step1
