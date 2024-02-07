require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

def number?(num)
  num.to_i.to_s == num || num.to_f.to_s == num
end

def operator?(num)
  %[1 2 3 4].include?(num)
end

def valid_number?(input_prompt, invalid_prompt, lang)
  input = ''
  loop do
    prompt(message(input_prompt, lang))
    input = Kernel.gets.chomp
    if number?(input) then break else prompt(message(invalid_prompt, lang)) end
  end
  input
end

def valid_operator?(input_prmpt, invalid_prmpt, lang)
  input = ''
  loop do
    prompt(message(input_prmpt, lang))
    input = Kernel.gets.chomp
    if operator?(input) then break else prompt(message(invalid_prmpt, lang)) end
  end
  input
end

def message(message_key, lang='en')
  MESSAGES[lang][message_key]
end

def perform_operation(operator, num1, num2)
  case operator
  when '1'
    num1.to_i() + num2.to_i()
  when '2'
    num1.to_i() - num2.to_i()
  when '3'
    num1.to_i() * num2.to_i()
  when '4'
    num1.to_f() / num2.to_f()
  end
end

operation_to_message = {
  '1' => 'Adding',
  '2' => 'Subtracting',
  '3' => 'Multiplying',
  '4' => 'Dividing'
}

prompt(message('welcome'))
lang = 'en'
loop do
  lang = Kernel.gets().chomp()
  if %w[en fr].include?(lang)
    break
  else
    prompt(message('invalid_language'))
  end
end

prompt(message('greeting', lang))

loop do # main loop
  Kernel.system("clear")
  number1 = valid_number?('number1_prompt', 'invalid_number', lang)
  number2 = valid_number?('number2_prompt', 'invalid_number', lang)
  operator = valid_operator?("operator_prompt", "invalid_operator", lang)

  if number2 == '0' && operator == '4'
    prompt(message("division_by_0", lang))
    sleep() until Kernel.gets.chomp
    next
  end

  prompt("#{operation_to_message[operator]} #{message('two_numbers', lang)}")

  result = perform_operation(operator, number1, number2)

  prompt("#{message('result_prompt', lang)} #{result}")

  prompt(message("another_calculation?", lang))
  continue = Kernel.gets().chomp()
  break unless %[y].include?(continue.downcase)
end

prompt(message("goodbye_prompt", lang))
