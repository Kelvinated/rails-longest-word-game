require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ("A".."Z").to_a.sample
    end
    return @letters
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    lookup = open(url).read
    result = JSON.parse(lookup)
    attempt = @word.upcase.split("")

    valid = attempt.all? { |letter| attempt.count(letter) <= @letters.count(letter) }

    if valid == false
      @result = "Sorry but #{@word} can't be built out of #{@letters}"
    elsif result["found"] == false
      @result = "Sorry but #{@word} does not seem to be a valid English word..."
    else
      @result = "Congratulations! #{@word} is a valid English word!"
    end
  end
end

# {"found"=>true, "word"=>"on", "length"=>2}
# {"found"=>false, "word"=>"nwg", "error"=>"word not found"}
