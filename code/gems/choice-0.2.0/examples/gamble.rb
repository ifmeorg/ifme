$:.unshift "../lib"
$:.unshift "lib"
require 'choice'

suits = %w[clubs diamonds spades hearts]
stringed_numerics = (1..13).to_a.map { |a| a.to_s }
valid_cards = stringed_numerics + %w[jack queen king ace]
cards = {}
stringed_numerics.each { |n| cards[n] = n }
cards.merge!('1' => 'ace', '11' => 'jack', '12' => 'queen', '13' => 'king')

Choice.options do
  header "Gambling is fun again!  Pick a card and a suit (or two), then see if you win!"
  header ""
  header "Options:" 
  
  option :suit, :required => true do
    short '-s'
    long '--suit *SUITS'
    desc "The suit you wish to choose.  Required.  You can pass in more than one, even."
    desc "  Valid suits: #{suits * ' '}"
    valid suits
  end

  separator ''

  option :card, :required => true do
    short '-c'
    long '--card CARD'
    desc "The card you wish to gamble on.  Required.  Only one, please."
    desc "  Valid cards: 1 - 13, jack, queen, king, ace"
    valid valid_cards
    cast String
  end
end

suit = suits[rand(suits.size)]
card = cards[(rand(13)+1).to_s]

puts "I drew the #{card} of #{suit}."
puts "You picked the #{Choice.choices.card} of #{Choice.choices.suit * ' or '}."
puts "You " << (Choice.choices.suit.include?(suit) && card == cards[Choice.choices.card] ? 'win!' : 'lose :(')
