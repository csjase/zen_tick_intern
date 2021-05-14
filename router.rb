class Router
  def initialize(controller)
    @controller = controller
    @running    = true
  end

  def run
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
        View.all_tickets
      elsif input == '2'
        View.ticket_choice
      else
        puts "Wrong input. Please try again."
        print "> "
      end
      input = menu_options
    end
  end

  private

  def menu_options
    puts ""
    puts "Select view options:"
    puts "* Press 1 to view ALL tickets"
    puts "* Press 2 to view a ticket"
    puts "* Type 'quit' to exit"
    print "> "
    input = gets.chomp.downcase
    input
  end
end
