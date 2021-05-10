require_relative "app/tickets_view"

def aut_header
  aut_encode = Base64.strict_encode64("#{ENV['ZENDESK_API_AUT']}")
  headers = "Basic #{aut_encode}"
end

current_index = 0
ticket_id_to_index = {}
tickets = []
response = HTTParty.get('https://zinterntest.zendesk.com/api/v2/requests.json', headers: {"Authorization" => "#{aut_header}"})
whole_json = JSON.parse(response.body)
requests_list = whole_json["requests"]
requests_list.each do |request_item|
  t = Ticket.new(request_item["id"], 
                 request_item["status"], 
                 request_item["subject"],
                 request_item["updated_at"])
  tickets << t
  ticket_id_to_index[request_item["id"]] = current_index #creating a hash map
  current_index += 1
end

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

def ticket_choice(ticket_id_to_index, tickets)
  puts "Enter ticket number: "
  print "> "
  input = gets.chomp.to_i
  ticket_id = input
  index_of_id = ticket_id_to_index[ticket_id]
  puts "| Ticket #".center(10) +
       "| Status" +
       "| Subject".center(45) +
       "| Updated At".center(30) +
       "|"                                                       
  puts "|" + "#{tickets[index_of_id].id}".center(9) +
       "|" + "#{tickets[index_of_id].status.capitalize}".center(8) +
       "|" + "#{tickets[index_of_id].subject}".center(44) +
       "|" + "#{tickets[index_of_id].updated_at}".center(10) +
       "|"       
end

def all_ticket(tickets)
  puts "-----------------------------------"
  puts "----------- All Tickets------------"
  puts "-----------------------------------"
  puts "|Ticket # | Status | Subject                                                     | Updated At |"
  tickets.each do |ticket|
    puts "|   #{ticket.id}     |    #{ticket.status[0].capitalize}    | #{ticket.subject}   | #{ticket.updated_at} |"
    puts ""
  end
end