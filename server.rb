#!/usr/bin/env ruby
require 'socket'
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
         message = connection.gets.chomp
         bye_user(message, username)
         puts @connected_clients
         (@connected_clients).keys.each do |client|
            @connected_clients[client].puts "#{username} : #{message}"
         end
      end
   end
end

Server.new("localhost",8080)
