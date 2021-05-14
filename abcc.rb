require_relative "tickets_controller"
require_relative "tickets_view"

puts "-----------------------------------------------------------------------------------------------"
puts "----------------------------- Welcome to Tickets Viewer ---------------------------------------"
puts "-----------------------------------------------------------------------------------------------"
puts "Type 'menu' to view options or 'quit' to exit"
print "> "
input = gets.chomp.downcase

while input != 'quit' && input != 'menu'  
  puts "Wrong input, please type 'menu' or 'quit' ONLY"
  print "> "
  input = gets.chomp.downcase
end 

if input == "quit"
  exit
end

input = menu_options

while input != 'quit'
  if input == '1'
    all_tickets
  elsif input == '2'
    ticket_choice
  else
    puts "Wrong input. Please try again."
    print "> "
  end
  input = menu_options
end