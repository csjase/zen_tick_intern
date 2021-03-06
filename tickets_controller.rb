require 'rubygems'
require 'httparty'
require "json"
require 'pry-byebug'
require 'base64'
require 'dotenv/load'
require 'date'
require_relative "zendesk_api"
require_relative "tickets"

def aut_header
  aut_encode = Base64.strict_encode64("#{ENV['ZENDESK_API_AUT']}")
  headers = "Basic #{aut_encode}"
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

def ticket_choice
  puts "Enter ticket number: "
  print "> "
  input = gets.chomp.to_i
  ticket_id = input
  api = Zendesk_TicketAPI.new('https://zinterntest.zendesk.com/api/v2', aut_header)
  ticket = api.chosen_ticket(ticket_id)
  puts "| Ticket #| Status |          Subject                           |     Updated At     |"
  puts "|" + "#{ticket.id}".center(9) +
       "|" + "#{ticket.status.capitalize}".center(8) +
       "|" + "#{ticket.subject}".center(44) +
       "|" + "#{ticket.updated_at}".center(10) +
       "|"       
end


def all_tickets
  puts "-----------------------------------------------------------------------------------------------"
  puts "---------------------------------------- All Tickets-------------------------------------------"
  puts "-----------------------------------------------------------------------------------------------"
  puts "|  Ticket #  | Status  |   Subject                                       |      Updated At      |"
  # ticket_start = 0
  page_answer = ""
  page = 1
  per_page = 25
  api = Zendesk_TicketAPI.new('https://zinterntest.zendesk.com/api/v2', aut_header)
  while page_answer != "menu"
    tickets = api.get_tickets(per_page, page)
    longest_length = 0
    tickets.each do |ticket|
      if ticket.subject.length > longest_length
        longest_length = ticket.subject.length
      end
    end
    tickets.each do |ticket|
      puts "|   #{ticket.id.to_s.ljust(4)}     |    #{ticket.status[0].capitalize}    | #{ticket.subject.ljust(longest_length)}   | #{ticket.updated_at} |"
    end
    
    if page == 1
      puts "Please type 'next' for more tickets or 'menu' to go back to main menu."
      print "> "
      page_answer = gets.chomp.downcase
    elsif page > 1  
      puts "Please type 'back' for last set of tickets, 'next' for next set of tickets or 'menu' to go back to main menu."
      print "> "
      page_answer = gets.chomp.downcase
      while page_answer != "next" && page_answer != "menu" && page_answer != "back"
        puts "Wrong input, please input either 'back', 'next' or 'menu'"
        print "> "
        page_answer = gets.chomp.downcase
      end
    end

    if page_answer == "next"
      page += 1
    elsif page_answer == "back"
      page -= 1
    end
  end
end


