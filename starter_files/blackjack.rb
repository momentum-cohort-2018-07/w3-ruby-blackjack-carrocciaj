tputs "TODO Implement the game of blackjack."

# Hint: for starters, read bin/blackjack.rb
class Card
  attr_accessor :rank
  attr_accessor :suit
  
  def initialize(rank, suit)
    @suit = suit
    @rank = rank
  end

  def rank_value
    case @rank
    when :A
      1
    when 1..10
      @rank
    when :J
      10
    when :Q
      10
    when :K
      10
    end
  end

  def ==(other_card)
    self.suit == other_card.suit &&
    self.rank == other_card.rank
  end

  def greater_than?(other_card)
    self.rank_value > other_card.rank_value
  end
end

class Deck
  attr_accessor :deck
  def initialize
      @deck = []
      create_deck
  end

  def create_deck
      suit_array = [ :clubs, :diamonds, :hearts, :spades ]
      rank_array = [ :A, 2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K]
      suit_array.each do |suit|
        rank_array.each do |rank|
          @deck.push(Card.new(rank,suit))
        end
      end
  end
  def draw
    @deck.shift
  end

  def shuffle
    @deck.shuffle!
  end

  def cards_left
    @deck.length
  end
end

class BlackjackGame
  attr_accessor :deck
  attr_accessor :player_hand_array
  attr_accessor :player_total
    def initialize
      @deck = Deck.new
      @deck.shuffle
    end
  
    def start_game
      @money = 100
      puts "Welcome to Josh's Blackjack Table, here is $#{@money} to get you started!"
    end
    def round
      # @bet = 10
      @player_hand_array = []
      2.times {player_hand_array << self.player_hand}
      player_total
  
      puts "You have #{self.player_hand_array[0].rank} and #{self.player_hand_array[1].rank}, your total is #{@total}"
      print 'Do you want to (h)it or (s)tand?'
      answer = gets.chomp.downcase
  
      if answer == 'h' then
      hit
      end
  
    end
    def hit 
        player_hand_array << self.player_hand
        # @total += self.player_hand_array[2].rank_value
        player_total
        puts "You have #{self.player_hand_array[0].rank} #{self.player_hand_array[1].rank} and #{self.player_hand_array[2].rank} your total is #{@total}"
        print 'Do you want to (h)it or (s)tand?'
        answer = gets.chomp.downcase
        if answer == 'h' then
          hit
        else
          @total
          end
       
    end
  
    def player_total 
      @total = 0
      @player_hand_array.each  do |card|
        @total += card.rank_value
      end
    end
    def player_hand
      card = @deck.draw
      # total = card1.rank_value + card2.rank_value
      # puts "You have #{card1.rank} and #{card2.rank}, your total is #{total}"
      
    end
  end

# create deck on inititalize
# start game with greeting
# deal hand to player
# return cards and total
# ask to hit or stand
# if hit deal one card else submit total
# if total greater then 21, bust and got to new hand
# else show final total
# deal hand to dealer
# determine if dealer needs to hit or stand
# return total or bust comment
# if dealer total > player total
# return you lose comment
# else return you win 
# add or subtract bet to money total
# deal new hand

