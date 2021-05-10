require 'rubygems'
require 'httparty'
require "json"
require 'pry-byebug'
require 'base64'
require 'dotenv/load'


class Ticket
  attr_reader :id, :status, :subject 
  def initialize(id, status, subject)
    @id = id
    @status = status
    @subject = subject
  end
end

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
  t = Ticket.new(request_item["id"], request_item["status"], request_item["subject"])
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
  input =  gets.chomp.downcase
  input
end

def ticket_choice(ticket_id_to_index, tickets) 
  puts "Enter ticket number: "
  input = gets.chomp.to_i
  ticket_id = input
  index_of_id = ticket_id_to_index[ticket_id]
  puts "Ticket # | Status | Subject"
  puts "#{tickets[index_of_id].id} | #{tickets[index_of_id].status} | #{tickets[index_of_id].subject} "
end

puts "Welcome to the ticket viewer!"
puts "Type 'menu' to view options or 'quit' to exit"
input = gets.chomp.downcase

while input != 'quit' && input != 'menu'  
  puts "Wrong input, please type 'menu' or 'quit' ONLY"
  input = gets.chomp.downcase
end 

if input == "quit"
  exit
end

input = menu_options

while input != 'quit'
  if input == '1'
    puts "Ticket # | Status | Subject"
    tickets.each do |ticket|
      puts "#{ticket.id} | #{ticket.status[0].capitalize} | #{ticket.subject}"
      puts " "
    end
  elsif input == '2'
    ticket_choice(ticket_id_to_index, tickets)
  else
    puts "Wrong input. Please try again."
  end
  input = menu_options
end

