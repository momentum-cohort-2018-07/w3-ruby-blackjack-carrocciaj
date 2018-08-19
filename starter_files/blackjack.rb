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
  attr_accessor :game_deck
  attr_accessor :player_hand_array
  attr_accessor :player_total
  attr_accessor :money
  attr_accessor :dealer_hand
  attr_accessor :array_to_string
  attr_accessor :rank_array
  attr_accessor :non_ace_total
  attr_accessor :num_aces

    def initialize
      @game_deck = Deck.new
      @game_deck.shuffle
      start_game
    end
    def inspect
    end
    def start_game
      puts "Welcome to Josh's Blackjack Table, here is $#{@money} to get you started!\n\n"
      print "Are you ready to play? (y)es or (n)o?"
      answer = gets.chomp.downcase
      if answer == 'y' then
        round 
      elsif answer == 'n' then
       puts "Come Back Again!"
      end
    end

    def round
      player_hand
      dealer
      player_total
      player_message
      hand_test
    end

    def hit 
      print 'Do you want to (h)it or (s)tand?'
      answer = gets.chomp.downcase
      if answer == 'h' then
        player_hand_array << self.deal_card
        player_total
        player_message
        hand_test
      elsif answer == 's' then
        stand
      end
    end

    def stand
     puts "Your score is #{@total}!"
     dealer_message
     winner
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

    def winner
      if @total <= 21 && @total >@total_dealer then
        puts "Winner, Winner, Chicken Dinner!"
      else
        puts "You Lose!"
      end
    end

    def player_total
      player_rank_array
      @total = 0
      @non_ace_total = 0
      @player_hand_array.each  do |card|
        if card.rank_value != 1 && rank_array.include?(:A) == false then
          @total += card.rank_value
        elsif card.rank_value != 1 && rank_array.include?(:A) then
          @non_ace_total += card.rank_value
        end
      end
        if @non_ace_total <= 10  && rank_array.include?(:A) then
          @num_aces = rank_array.count(:A)
          @total += 11 + @num_aces -1 + @non_ace_total
        elsif @total > 10  && rank_array.include?(:A) then
          @total +=1
        end
    end

    def player_array_to_string
        @array_to_string = []
        @player_hand_array.map do |rank|
          array_to_string << rank.rank
        end
    end

    def player_message
      player_array_to_string
      puts "Your hand is #{@array_to_string}! Your total is #{@total}\n\n"
      puts "#{@non_ace_total}"
      puts "#{@total}"
      show_dealer_card
    end

    def dealer_total
      @total_dealer = 0
      @dealer_hand.each do |card|
        @total_dealer += card.rank_value
      end
      dealer_hit_or_stay
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
    end
    
    def show_dealer_card
      puts "Dealer shows #{self.dealer_hand[0].rank} of #{self.dealer_hand[0].suit}." 
      puts "#{@dealer_hand}"
    end

    def dealer
      @dealer_hand = []
      2.times {dealer_hand << self.deal_card}
    end
    
    def dealer_message
      dealer_total
      if @total_dealer <= 21 then
        puts "Dealer's total is #{@total_dealer}"
      else
        puts "Dealer Busted!"
      end
    end

    def deal_card
      @game_deck.draw
    end
    
    def dealer_hit_or_stay
      if @total_dealer < 16 then
        dealer_hand << self.deal_card
        dealer_total
      end
    end

    def player_rank_array
      @rank_array = []
      @player_hand_array.each do |rank|
      @rank_array << rank.rank
      end
    end
end
