require 'pry'

# Really should refactor the answer check logic into methods

def prompt(message)
  puts "=> #{message}"
end

prompt '------LOAN CALCULATOR------'
loop do
  prompt 'How much money do you need?'

  loan_amount = ''
  loop do
    loan_amount = gets.chomp

    # make it work if someont puts a $ with their loan amount
    if loan_amount.start_with?('$')
      loan_amount = loan_amount.delete '$'
    end

    # account for an empty, non-numerical string or negative number answer
    # convert to float
    if loan_amount == "0"
      prompt 'Come on...I know you need some money. Seriously, how much?'
    elsif loan_amount.empty? || loan_amount.to_f <= 0.0
      prompt 'Please enter a positive dollar amount.'
    else
      loan_amount = loan_amount.to_f
      break
    end
  end

  loan_duration = ''
  prompt 'How many months is this loan for?'
  loop do
    loan_duration = gets.chomp

    # account for empty, non-numeral, 0, negative
    if loan_duration.empty? || loan_duration.to_i <= 0
      prompt 'Please enter a positive number of months.'
    else
      loan_duration = loan_duration.to_i
      break
    end
  end

  apr = ''
  prompt 'What is your Annual Percentage Rate?'

  loop do
    apr = gets.chomp

    # make it work if someont puts a % with their percentage
    if apr.end_with?('%') == true
      apr = apr.delete '%'
    end

    # account for empty, negative numeral, or non-numeral
    if apr == "0"
      apr = apr.to_f
      break
    elsif apr.empty? || apr.to_f <= 0.0
      prompt 'Please enter a percentage (ex: 2.99).'
    else
      apr = apr.to_f / 100.00
      break
    end
  end

  # calculate monthly payment
  if apr == 0.0
    monthly_payment = loan_amount / loan_duration
  else
    monthly_interest = apr / 12
    monthly_payment = loan_amount * ((monthly_interest * (1 + monthly_interest)**loan_duration) / ((1 + monthly_interest)**loan_duration - 1))
  end

  monthly_payment = format("%.2f", monthly_payment)
  puts "Your monthly payment would be: $#{monthly_payment}"

  prompt "Would you like to perform another calculation? (Yes or No?)"
  answer = gets.chomp
  break unless answer.downcase.start_with? 'y'
  puts "Great! Let's go again."
end

puts "Okay. Thanks for using the loan calculator!"
