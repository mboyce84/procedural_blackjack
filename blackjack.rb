# Procedural Blackjack game built using Ruby

# CLASSES BEGIN #

# Colorized Ruby Output
class String
def red;            "\033[31m#{self}\033[0m" end
def green;          "\033[32m#{self}\033[0m" end
def magenta;        "\033[35m#{self}\033[0m" end
def cyan;           "\033[36m#{self}\033[0m" end
def bg_blue;        "\033[44m#{self}\033[0m" end
end

# CLASSES END #

# METHODS BEGIN #

# Calculates the current score of player/dealer
def calculate_total(cards)
  # [['H', '3'], ['S', 'Q'], ... ]

  arr = cards.map{|e| e[1]}
  
  total = 0
  arr.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0 # J, Q, K
      total += 10
    else
      total += value.to_i
    end
  # Logic for Aces
  end
  arr.select{|e| e == "A"}.count.times do
    total -= 10 if total > 21
  end

  return total
end

# Method for the replay logic and input validation
def replay(play_again_choice)
  if play_again_choice == 'y' || play_again_choice == 'yes'
    puts "\n---------Good luck---------\n"
    sleep(2)
    system('cls')
  elsif play_again_choice == 'n' || play_again_choice == 'no'
    puts "\n---------Thanks for playing!---------\n"
    exit
  else
    puts "\nInvalid response entered. Would You Like to Play again? (Yes/No)"
    play_again_choice = gets.chomp.downcase
    replay(play_again_choice)
  end
end

# METHODS END #

# MAIN APPLICATION BEGIN #

# Setup program
system('cls')
puts "-----BlackJack 21-----"
sleep(1)
print "\nWhat is Your Name? > "
player_name = gets.chomp.capitalize 
sleep(1)
system('cls')
puts "Hello #{player_name}, Welcome to the BlackJack Table!"
puts ""
sleep(2)

# Setup deck
suits = ['H', 'D', 'S', 'C']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = suits.product(cards)
deck.shuffle!

loop do

# Deal cards
puts "Please Wait While the Dealer is Passing Out Cards..."

sleep(2)

player_cards = []
dealer_cards = []

player_cards << deck.pop
dealer_cards << deck.pop
player_cards << deck.pop
dealer_cards << deck.pop

dealer_total = calculate_total(dealer_cards)
player_total = calculate_total(player_cards)

# Show cards
puts "\nDealer has: " + "#{dealer_cards[0]}".bg_blue + " and " + "#{dealer_cards[1]}".bg_blue + ", for a total of #{dealer_total}"
puts "\nYou have: "+ "#{player_cards[0]}".bg_blue + " and " + " #{player_cards[1]}".bg_blue + ", for a total of #{player_total}"

# Player turn
if player_total == 21
  puts "\nCongratulations, you hit blackjack! " + "You win!".green
  exit
end

while player_total < 21
  print "\nWhat would you like to do?" + "" + " 1) HIT".green + " 2) STAY ".red + "> "
  hit_or_stay = gets.chomp

  if !['1', '2'].include?(hit_or_stay)
    puts "\nInvalid response entered: you must enter 1 or 2"
    next
  end

  if hit_or_stay == "2"
    puts "\nYou chose to stay."
    break
  end

  # Hit
  new_card = deck.pop
  sleep(1)
  puts "\nThe Dealer is passing you a new card: " + " #{new_card}".bg_blue
  player_cards << new_card
  player_total = calculate_total(player_cards)
  puts "\nYour total is now: #{player_total}"

  if player_total == 21
    sleep(1)
    puts "\nCongratulations #{player_name}, you hit blackjack! You win!".green
    exit
  elsif player_total > 21
    sleep(1)
    puts "\nSorry #{player_name}, it looks like you busted! You lose.".red
    exit
  end
end

# Dealer turn
if dealer_total == 21
  sleep(1)
  puts "\nSorry #{player_name}, dealer hit blackjack. You lose.".red
  exit
end

while dealer_total < 17
  # Hit
  new_card = deck.pop
  sleep(1)
  puts "\nDealing new card for dealer: " + "#{new_card}".bg_blue
  dealer_cards << new_card
  dealer_total = calculate_total(dealer_cards)
  sleep(1)
  puts "\nDealer total is now: #{dealer_total}"

  if dealer_total == 21
    puts "\nSorry #{player_name}, dealer hit blackjack. You lose.".red
    exit
  elsif dealer_total > 21
    puts "\nCongratulations #{player_name}, dealer busted! You win!".green
    exit
  end
end

# Compare hands
sleep(2)
system('cls')
puts "Time to Compare Hands"
sleep(2)
puts "----------------------------"
puts "\nDealer's cards: "
dealer_cards.each do |card|
  puts "=> " + "#{card}".bg_blue
end
puts "Dealer total = " + "#{dealer_total}"
puts ""

puts "Your cards:"
 player_cards.each do |card|
  puts "=> " + "#{card}".bg_blue
end
puts "Your total = " + "#{player_total}"
puts ""
puts "----------------------------"
sleep(2)
if dealer_total > player_total
  puts "\nSorry #{player_name}, dealer wins. You lose.".red
elsif dealer_total < player_total
  puts "\nCongratulations #{player_name}, you win!".green
else
  puts "It's a tie!".magenta
end

# Replay logic
  sleep(1)
  print "\nWould you like to play another game of Blackjack? (Yes/No) > "
  play_again_choice = gets.chomp.downcase
  replay(play_again_choice)
end

# MAIN APPLICATION END #