require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    # build grid
    @grid = create_grid(10).join
  end

  def score
    # retrieve all game data from form
    @word = params[:attempt]
    if @result
      @sentence = "Congratulations! #{@word} is a valid English word!"
    else
      @sentence = "Sorry but #{@word} does not seem to be valid English word..."
    end
  end


  private

  def create_grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a[rand(26)]}
  end

  def check_word(word)
      response = open("http://wagon-dictionary.herokuapp.com/#{word.downcase}")
      word_serialized = URI.open(url).read
      word = JSON.parse(word_serialized)
      @result = word["found"]
  end

end
