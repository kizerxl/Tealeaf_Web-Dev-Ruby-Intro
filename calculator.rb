#Tealeaf calculator 

def calculate operation,num1,num2   
  case operation 
    when "1"
      result = num1.to_i + num2.to_i
    when "2"
      result = num1.to_i - num2.to_i
    when "3"
      result = num1.to_i * num2.to_i
    when "4"
      result = num1.to_f / num2.to_f
    end
    result 
end 

def Is_Valid? operation,num1,num2
  valid_operations = ["1","2","3","4"]
  if operation == "4" && num2.to_i == 0 #check for division by zero 
    valid = false
  elsif 
    valid = valid_operations.include?(operation)
  end  
  valid
end 


begin 
  puts "------------------------------------"
  puts ""
  puts "Please enter your first number:"
  num1 = gets.chomp 
  puts ""
  puts "Please enter your second number:"
  num2 = gets.chomp
  puts ""
  puts "Choose an operation: 1. Addition 2. Subtraction 3. Multiplication 4. Division" 
  operation = gets.chomp 
  puts ""
  if Is_Valid?(operation,num1,num2)
      answer = calculate(operation,num1,num2)
      puts "Your answer is #{answer}"
      puts ""
      puts "Perform another calculation (y/n)?"
      choice = gets.chomp.downcase
  else 
    puts "Invalid operation" 
  end 

  end while (choice == "y")
