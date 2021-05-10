require_relative "../zen_tick_intern/tickets_controller"

puts "Welcome to the ticket viewer!"
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
    all_ticket(tickets)
  elsif input == '2'
    ticket_choice(ticket_id_to_index, tickets)
  else
    puts "Wrong input. Please try again."
    print "> "
  end
  input = menu_options
end