#use Rubys Socket Library
require 'socket'

server = TCPServer.new(3000)

#Accept incoming connection
loop do
  client = server.accept
end
#Get input from client side

client.puts "What's your name?"
input = client.gets
puts "Received #{input.chomp} from a client socket 1337"
client.puts "Hi, #{input.chomp}! You've successfully connected to server socket."

#Close the client socket
puts "Closing client socket"
client.puts "Goodbye #{input}"
client.closerub