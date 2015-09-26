require 'pry'

GAME_CHOICES = { 'rock' => ['r', 'ro', 'roc'],
                 'paper' => ['p', 'pa', 'pap', 'pape'],
                 'scissors' => ['sc', 'sci', 'scissor'],
                 'lizard' => ['l', 'li', 'liz'],
                 'spock' => ['sp', 'spo', 'spoc'] }

WHAT_BEATS_WHAT = { "rock" => %w(scissors lizard),
                    "paper" => %w(rock spock),
                    "scissors" => %w(paper lizard),
                    "lizard" => %w(spock paper),
                    "spock" => %w(scissors rock) }

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
  if user == computer
    prompt "It's a tie."
  elsif WHAT_BEATS_WHAT[user].include?(computer)
    prompt "You won!"
  else
    prompt "You lost."
  end
end

user_score = 0
computer_score = 0
loop do
  user_choice = ''
  loop do
    prompt "Choose one: #{GAME_CHOICES.keys.join(', ')}"
    user_choice = gets.chomp.downcase

    # format the answer: reject if empty, accept if it's one of approved shorthands
    # if accepted, reformat user_choice to match appropriate key value
    GAME_CHOICES.each do |key, _|
      if user_choice.empty? # empty input returns true for below statement.
        break
      elsif GAME_CHOICES[key].join(' ').include?(user_choice)
        user_choice = key
      end
    end

    # officially accept/reject the answer
    # tried to add this to previous if statement, but it would print out
    # the "not a valid choice" message for each key rather than just once.
    if GAME_CHOICES.key?(user_choice)
      break
    else
      prompt "That's not a valid choice."
    end
  end

  # computer makes a choice
  computer_choice = GAME_CHOICES.keys.sample

  # result is displayed
  puts "You chose: #{user_choice.upcase} | Computer chose: #{computer_choice.upcase}"
  alt_display_results(user_choice, computer_choice)

  # update and display score
  if WHAT_BEATS_WHAT[user_choice].include?(computer_choice)
    user_score += 1
  elsif WHAT_BEATS_WHAT[computer_choice].include?(user_choice)
    computer_score += 1
  end
  puts "The score is YOU: #{user_score} | COMPUTER: #{computer_score}"

  # after someone wins, reset the score variables
  if user_score == 5
    puts "\nCONGRATS! You beat the computer."
    user_score = 0
    computer_score = 0
  elsif computer_score == 5
    puts "\nUh oh! The computer beat you."
    user_score = 0
    computer_score = 0
  end

  prompt "\nDo you want to continue?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thank you for playing. Goodbye!"
