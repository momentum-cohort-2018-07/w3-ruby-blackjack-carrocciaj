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
  attr_accessor :card_array
  attr_accessor :dealer_rank
  attr_accessor :win_count

    def initialize
      @game_deck = Deck.new
      @game_deck.shuffle
      @wallet = 100
      start_game
    end
    def inspect
      @card_array = []
      self.game_deck.deck.map do |i|       
        @card_array << "#{i.rank} of #{i.suit}"
      end
      # puts "Bye"
    end
    # def to_s
    #   self.game_deck.deck.each do |i|       
    #     puts "#{i.rank} of #{i.suit}"
    #   end
    # end
    def start_game
      @money = 100
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
      # dealer
    end

    def deal_card
      @game_deck.draw
    end
    
    # def wallet
    #   @money = 100
    # end

    def bet
     @bet = 10
    end

    def wallet_balance
      # wallet
      bet
      if @win_count == 1 then
        @money += @bet
      elsif @win_count == -1 then
        @money -= @bet
      elsif @win_count ==0 then
        @money += 0
      end
      balance_message
    end

    def balance_message
      puts "You have $#{@money} left"
    end

    def player_hand
      @player_hand_array = []
      2.times {player_hand_array << self.deal_card}
    end

    def dealer
      @dealer_hand = []
      2.times {dealer_hand << self.deal_card}
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

    def player_rank_array
      @rank_array = []
      @player_hand_array.each do |rank|
      @rank_array << rank.rank
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
      show_dealer_card
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
      wallet_balance
       print 'Do you want to play again (y)es or (n)o?'
         answer = gets.chomp.downcase
         if answer == 'y' then
          self.round
         else
          puts 'Thanks for Playing'
         end
    end

    def winner
      @win_count = 0
      if @total <= 21 && @total >@total_dealer || @total_dealer > 21 then
        puts "Winner, Winner, Chicken Dinner!"
        @win_count = 1
      elsif @total <= 21 && @total_dealer <= 21 && @total<@total_dealer
        puts "You Lose!"
        @win_count = -1
      elsif @total == @total_dealer then
        puts "Draw! Split Pot"
        @win_count = 0
      end
    end

    def dealer_rank_array
      @dealer_rank = []
      @dealer_hand.each do |rank|
      @dealer_rank << rank.rank
      end
    end

    def dealer_total
      dealer_rank_array
      @total_dealer = 0
      non_ace_total = 0
      @dealer_hand.each do |card|
        if card.rank_value != 1 && dealer_rank.include?(:A) == false then
          @total_dealer += card.rank_value
        elsif card.rank_value != 1 && dealer_rank.include?(:A) then
          non_ace_total += card.rank_value
        end
      end
      if non_ace_total <= 10  && dealer_rank.include?(:A) then
        num_aces = dealer_rank.count(:A)
        @total_dealer += 11 + num_aces -1 + non_ace_total
      elsif @total_dealer > 10  && dealer_rank.include?(:A) then
        @total_dealer +=1
      end
      dealer_hit_or_stay
    end

    
    def dealer_hit_or_stay
      if @total_dealer < 16 then
        dealer_hand << self.deal_card
        dealer_total
      end
    end
    
    def show_dealer_card
      puts "Dealer shows #{self.dealer_hand[0].rank} of #{self.dealer_hand[0].suit.capitalize}." 
      puts "#{self.dealer_hand.to_s}"
    end
    
    def dealer_message
      dealer_total
      if @total_dealer <= 21 then
        puts "Dealer's total is #{@total_dealer}"
      else
        puts "Dealer Busted!"
      end
    end
end

BlackjackGame.new