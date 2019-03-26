require 'socket'
<<<<<<< HEAD
require './Chat_command.rb'
class Server
  def initialize(socket_address, socket_port)
     @server_socket = TCPServer.open(socket_port, socket_address)
     @connected_clients = Hash.new
     puts 'Started server.........'
     run
  end
   def establish_chatting(username, connection)
      loop do
=======
require './functions'

class Server
  def initialize(socket_port, socket_address)
    @server_socket = TCPServer.open(socket_port, socket_address)
    @connected_clients = Hash.new
    puts 'Started server.........'
    run
  end

  def establish_chatting(username, connection)
    loop do
>>>>>>> master
         message = connection.gets.chomp
         bye_user(message, username)
         puts @connected_clients
         (@connected_clients).keys.each do |client|
            @connected_clients[client].puts "#{username} : #{message}"
         end
      end
   end
<<<<<<< HEAD
   chat_command
   def bye_user(message, username)
     if message == "/bye"
      puts "#{username} Goodbye friend !"
      @connected_clients[username].puts "quit"
     end
   end
end

Server.new(8080,"localhost")
=======
end

Server.new("localhost",8080)
>>>>>>> master
