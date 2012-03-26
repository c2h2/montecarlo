
STARTING_MONEY = 1000.0
EDGE = 0.015
BET_FRACTION = 0.1
MAX_TIMES = 5000

WINNING_CHANCE = 0.5 - EDGE



class Game

  def self.play_one_game gambler, bet
    game_result = WINNING_CHANCE > _rand
    if game_result
      gambler.bank += bet
    else
      gambler.bank -= bet
    end
    game_result
  end

  def self._rand
    rand
  end
end



class Gambler
  attr_accessor :games, :bank
  def initialize bankroll
    @start_money = bankroll
    @bank  = bankroll
    @games = []
  end
  
  def play
    puts "Starting to play game"
    prev_bank = @bank
    cnt = 0
    while play_one_game
      cnt += 1
      if cnt >= MAX_TIMES
        puts "Max # of games reached #{MAX_TIMES}, max was $#{@games.max}, now is #{@bank}."
        return 
      end
      
    end
    puts "LOST ALL, #{@games.count} games played, max was $#{@games.max}."
  end
  
  def play_one_game
    if @bank <= 1
      return false
      #bankrupt
    end
    res = Game.play_one_game(self, each_bet_amount)
    
    @games << @bank
    if res 
      #puts "WIN  | $#{@bank}"
    else
      #puts "LOST | $#{@bank}" 
    end
    
    true # still have money, return true
  end

  def each_bet_amount
    ##some else
    
    ## fixed
    @bet = @start_money * BET_FRACTION
    (@bank <= @bet)? @bank : @bet #if cant afford bet fraction, then just bank money
  
    
  end
end



g=Gambler.new STARTING_MONEY
g.play