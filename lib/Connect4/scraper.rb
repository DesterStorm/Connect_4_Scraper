require 'Open-uri'
require 'Nokogiri'
require 'pry'
require_relative 'game.rb'


class Scraper

  attr_accessor :doc, :steps

  # def call
  #   html = open('https://www.wikihow.com/Win-at-Connect-4#Learning-Basic-Strategies_sub')
  #   doc ||= Nokogiri::HTML(html)
  #   steps = doc.css('div.step b.whb').children.map{|name| name.text }.compact
  #   steps
  #   (0...steps.size).each do |i|
  #     puts "Tip: #{i + 1} #{steps[i]}\n"
  #   end
  # end

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
          title:  li_tag.css('div.step b').text,
          instruction:  li_tag.css('div.step').text.split("\n")[1...-1].join(' ')
      }
      strat_object.add_step(hash)
    end
  end
  # def get_steps
  #   @steps
  # end

  # scraper = Scraper.new
  # steps = scraper.get_steps
  #
  # # lists out the tips available
  # (0...steps.size).each do |i|
  #   puts "Tip: #{i + 1} #{steps[i]}\n"
  # end



  # def list_of_steps
  #   # control the center
  #   html = open('https://www.wikihow.com/Win-at-Connect-4')
  #   doc = Nokogiri::HTML(html)
  #   puts doc.css('#step-id-00 div.step b.whb').text.strip.gsub(".", " - 1")
  #   # plan multiple moves in advance
  #   html = open('https://www.wikihow.com/Win-at-Connect-4')
  #   doc = Nokogiri::HTML(html)
  #   puts doc.css('#step-id-01 div.step b.whb').text.strip.gsub(".", " - 2")
  #   # block your opponent
  #   html = open('https://www.wikihow.com/Win-at-Connect-4')
  #   doc = Nokogiri::HTML(html)
  #   puts doc.css('#step-id-02 div.step b.whb').text.strip.gsub(".", " - 3")
  #   # take advantage of your opponent's mistakes
  #   html = open('https://www.wikihow.com/Win-at-Connect-4')
  #   doc = Nokogiri::HTML(html)
  #   puts doc.css('#step-id-03 div.step b.whb').text.strip.gsub(".", " - 4")
  #   # play offensively
  #   html = open('https://www.wikihow.com/Win-at-Connect-4')
  #   doc = Nokogiri::HTML(html)
  #   puts doc.css('#step-id-04 div.step b.whb').text.strip.gsub(".", " - 5")
  #   # dont fill a slot under a game ending move
  #   html = open('https://www.wikihow.com/Win-at-Connect-4')
  #   doc = Nokogiri::HTML(html)
  #   puts doc.css('#step-id-05 div.step b.whb').text.strip.gsub(".", " - 6")
  # end

  # asks the user which tip they'd like more info on
  def step_info(strategy_object)
    q = nil
    strategy_object.steps.each.with_index(1) do |hash, index|
      puts "#{index}. #{hash[:title]}"
    end
    puts "\n Enter the number of the Pro-tip you'd like to know more about, 'back' to go back to the list of tips or 'play' to practice."
    until q == 'exit'
      q = gets.strip.downcase
      case q
      when (0..strategy_object.size).include?(q.to_i)
        puts "#{:instruction}"
      when 'back'
        Scraper.new
      when 'play'
        play = Play_Game.new
      else
        puts "I don't understand. Type 'back' or 'play' please."
      end
      # count = 0
      # html = open('https://www.wikihow.com/Win-at-Connect-4')
      # doc = Nokogiri::HTML(html)
      # steps = doc.css("ol.steps_list_2").children.map { |name| name.text.gsub("/\n\s+/", " ") }.compact
      # puts "\n Enter the number of the Pro-tip you'd like to know more about, 'back' to go back to the list of tips or 'play' to practice."



      # q
      # count += 1 until count == q
      #   puts "#{steps[q.to_i]}\n"
      #


      # when "1"
      #   html = open('https://www.wikihow.com/Win-at-Connect-4')
      #   doc = Nokogiri::HTML(html)
      #   puts doc.css("#step-id-0#{count} div.step").text.strip.gsub("WH.performance.mark('step1_rendered');", " ")
      # when "2"
      #   html = open('https://www.wikihow.com/Win-at-Connect-4')
      #   doc = Nokogiri::HTML(html)
      #   puts doc.css('#step-id-01 div.step').text.strip
      # when "3"
      #   html = open('https://www.wikihow.com/Win-at-Connect-4')
      #   doc = Nokogiri::HTML(html)
      #   puts doc.css('#step-id-02 div.step').text.strip
      # when "4"
      #   html = open('https://www.wikihow.com/Win-at-Connect-4')
      #   doc = Nokogiri::HTML(html)
      #   puts doc.css('#step-id-03 div.step').text.strip
      # when "5"
      #   html = open('https://www.wikihow.com/Win-at-Connect-4')
      #   doc = Nokogiri::HTML(html)
      #   puts doc.css('#step-id-04 div.step').text.strip
      # when "6"
      #   html = open('https://www.wikihow.com/Win-at-Connect-4')
      #   doc = Nokogiri::HTML(html)
      #   puts doc.css('#step-id-05 div.step').text.strip

    # end
  end
  end
  end


# test = Scraper.new
# test.step1

