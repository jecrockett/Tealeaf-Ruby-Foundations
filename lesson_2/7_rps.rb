GAME_CHOICES = %w(rock paper scissors)

# def test_method
#   prompt 'test message'
# end

# test_method

def prompt(message)
  puts "=> #{message}"
end

# def display_results(user, computer)
#     if (user == 'rock' && computer == 'scissors') ||
#       (user == 'scissors' && computer == 'paper') ||
#       (user == 'paper' && computer == 'rock')
#     prompt "You won!"
#   elsif (user == 'rock' && computer == 'paper') ||
#       (user == 'scissors' && computer == 'rock') ||
#       (user == 'paper' && computer == 'scissors')
#     prompt "You lost!"
#   else
#     prompt "It's a tie."
#   end
# end

def alt_display_results(user, computer)
  what_beats_what = { rock: "scissors",
                      paper: "rock",
                      scissors: "paper" }

  if user == computer
    prompt "It's a tie."
  elsif what_beats_what.values_at(user).include?(computer)
    prompt "You won!"
  else
    prompt "You lose."
  end
end
# FUCK YEAH THAT WORKED!!!
# pardon my lang...that was exciting.

loop do
  user_choice = ''
  loop do
    prompt "Choose one: #{GAME_CHOICES.join(', ')}"
    user_choice = gets.chomp

    if GAME_CHOICES.include?(user_choice)
      break
    else
      prompt "That's not a valid choice."
    end
  end

  # computer makes a choice
  computer_choice = GAME_CHOICES.sample

  # winner is displayed
  puts "You chose: #{user_choice} | Computer chose: #{computer_choice}"

  alt_display_results(user_choice, computer_choice)

  prompt "Do you want to play again?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thank you for playing. Goodbye!"
