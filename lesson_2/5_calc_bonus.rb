require 'yaml'
MESSAGES = YAML.load_file('5_calculator_messages.yml')

# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result

# answer = gets
# puts answer

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(message)
  puts "=> #{message}"
end

def number?(input)
  input.to_i.to_s == input || input.to_f.to_s == input
end

def operation_to_message(operator)
  result = case operator
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end

  george = "snuffaluffagus"

  result
end

prompt(messages('welcome'))

name = ''
loop do
  name = gets.chomp.capitalize

  if name.empty?
    prompt(messages('valid_name', 'cz'))
  else
    break
  end
end

prompt("Hi, #{name}!")

loop do # main loop
  number1 = ''
  loop do
    prompt(messages('number1'))
    number1 = gets.chomp

    if number?(number1)
      break
    else
      prompt(messages('valid_number'))
    end
  end

  number2 = ''
  loop do
    prompt(messages('number2'))
    number2 = gets.chomp

    if number?(number2)
      break
    else
      prompt(messages('valid_number'))
    end
  end

  # prompt("What operation would you like to perform? \n1) add \n2) subtract \n3) multiply \n4) divide")
  # Can do better formatting using an operator prompt...
  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  prompt(operator_prompt)
  operator = ''
  loop do
    operator = gets.chomp
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(messages('choose_operation'))
    end
  end

  # if operator == '1'
  #   result = number1.to_i + number2.to_i
  # elsif operator == '2'
  #   result = number1.to_i - number2.to_i
  # elsif operator == '3'
  #   result = number1.to_i * number2.to_i
  # else
  #   result = number1.to_f / number2.to_f
  # end

  prompt("#{operation_to_message(operator)} the two numbers...")

  number1 = number1.to_f
  number2 = number2.to_f
  result = case operator
           when '1'
             number1 + number2
           when '2'
             number1 - number2
           when '3'
             number1 * number2
           when '4'
             number1 / number2
           end

  prompt("The result is #{result}.")

  prompt(messages('go_again'))
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(messages('goodbye'))
