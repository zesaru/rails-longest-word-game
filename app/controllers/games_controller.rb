class GamesController < ApplicationController
require 'open-uri'
require 'json'
  def new
    @letters = gen_grilla(10)
  end

  def score
    @message
    if included?(params[:word], params[:grilla])
      if english_word?(params[:word])
        @message = "Congratulations! <strong>#{params[:word]}</strong> is a valid English Word"
      else
        @message = "Sorry but <strong>#{params[:word]}</strong> does not seem to be a valid English word"
      end
    else
      @message = "Sorry but <strong>#{params[:word]}</strong> can't be built out of <strong>#{params[:grilla]}</strong>"
    end
    @message
  end

  private

  def gen_grilla(grilla_size)
    Array.new(grilla_size) { ('A'..'Z').to_a.sample }
  end

  def included?(word_check, grilla)
    word_check.chars.all? { |letter| word_check.count(letter) <= grilla.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
