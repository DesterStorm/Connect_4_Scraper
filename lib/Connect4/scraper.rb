require 'Open-uri'
require 'Nokogiri'
# require_relative 'game.rb'

class Scraper

  attr_accessor :doc, :steps

  def initialize
    html = open('https://www.wikihow.com/Win-at-Connect-4#Learning-Basic-Strategies_sub')
    @doc ||= Nokogiri::HTML(html)
    @steps = doc.css('div.step b.whb').children.map{|name| name.text }.compact
    @tips = doc.css('#step-id-00 div.step').children.map{|name| name.text }.compact
  end

  def wiki
    html = open('https://en.wikipedia.org/wiki/Connect_Four')
    doc = Nokogiri::HTML(html)
    puts doc.css(".templatequote p").text.strip
    puts " "
  end

  def get_steps
    @steps
  end


  scraper = Scraper.new
  steps = scraper.get_steps

  # lists out the tips available
  (0...steps.size).each do |i|
    puts "Tip: #{i + 1} #{steps[i]}\n"
    # puts ""
  end

  def call
    step_info
  end







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
  def step_info
    q = nil
    while q != "exit"
      puts "\n Enter the number of the Pro-tip you'd like to know more about, 'back' to go back to the list of tips or 'play' to practice."
      q = gets.strip.downcase
      q
      html = open('https://www.wikihow.com/Win-at-Connect-4')
      doc = Nokogiri::HTML(html)
      steps = doc.css('div.step').children.map{|name| name.text }.compact
      (0...steps.size).each do |i|
        puts "#{steps[i]}\n"
      end
      # case q
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
      # when "back"
      #   list_of_steps
      # when "play"
      #   Game.new
      # else
      #   puts "I don't understand. Type 'back' or 'play' please."

    end
    step_info
  end
end

# test = Scraper.new
# test.step1

