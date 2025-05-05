require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ( 'A'.. 'Z').to_a.sample }
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{@word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    if included?(@word, @letters) && english_word?(@word)
      @outcome = "Well done! Your answer is a valid English word!"
    elsif !included?(@word, @letters)
      @outcome = "You can't use these letters."
    else
      @outcome = "This is not an English word!"
    end
  end
end
