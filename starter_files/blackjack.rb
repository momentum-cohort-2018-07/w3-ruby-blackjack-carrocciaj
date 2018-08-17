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
  attr_accessor :money
  attr_accessor :dealer_hand
  attr_accessor :dealer_total
  attr_accessor :array_to_string

    def initialize
      @deck = Deck.new
      @deck.shuffle
    end
  
    def start_game
      @money = 100
      puts "Welcome to Josh's Blackjack Table, here is $#{@money} to get you started!"
    end

    def round
      @bet = 10
      player_hand
      # @player_hand_array = []
      # 2.times {player_hand_array << self.deal_card}
      player_total
      # player_message
      puts "You have $#{@money} and you bet $#{@bet}"
      puts "You have #{self.player_hand_array[0].rank} and #{self.player_hand_array[1].rank}, your total is #{@total}"
      
      hand_test

      dealer
    end

    def hit 
      print 'Do you want to (h)it or (s)tand?'
      answer = gets.chomp.downcase
      if answer == 'h' then
        player_hand_array << self.deal_card
        # @total += self.player_hand_array[2].rank_value
        
        player_total
        player_message
        hand_test
        # hit
      elsif answer == 's' then
        stand
      end
    end

    def stand
     puts "Your score is #{@total}!"
     new_game 
    end
    def new_game
       print 'Do you want to play again (y)es or (n)o?'
         answer = gets.chomp.downcase
         if answer == 'y' then
          self.round
         else
          puts 'Thanks for Playing'
         end
    end
    def player_total 
      @total = 0
      @player_hand_array.each  do |card|
        @total += card.rank_value
      end
    end
    def player_array_to_string
        string = ''
        @array_to_string = string
        @player_hand_array.each do |rank|
          @array_to_string += rank.rank.to_s.center(2.5)
        end
    end
    def player_message
    player_array_to_string
    puts "You have #{@array_to_string}your total is #{@total}"
    end
    def dealer_total
      @total_dealer = 0
      @dealer_hand.each do |card|
        @total_dealer += card.rank_value
      end
    end

    def hand_test
      if @total == 21 then
        puts "Blackjack! you win!"
        new_game
      elsif @total >= 21 then
        puts "Bust, you lose!"
        new_game
      else
        hit
      end
    end
    def player_hand
      @player_hand_array = []
      2.times {player_hand_array << self.deal_card}
      # player_message
      # player_total
      # puts "You have $#{@money} and you bet $#{@bet}"
      # puts "You have #{self.player_hand_array[0].rank} and #{self.player_hand_array[1].rank}, your total is #{@total}"
    end
    def dealer
      @dealer_hand = []
      2.times {dealer_hand << self.deal_card}
      dealer_total
      puts "Dealer has #{self.dealer_hand[0].rank} and #{self.dealer_hand[1].rank}, your total is #{@total_dealer}"

    end
    def deal_card
      card = @deck.draw
    end
  end
# create deck on inititalize
# shuffle deck
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

