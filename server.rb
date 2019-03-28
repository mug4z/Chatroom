#!/usr/bin/ruby

require 'socket' # Sockets are in standard library
require './functions' # Call command-lines

class Server

  def initialize( ip, port )
    @server = TCPServer.open( ip, port )
    @connections_clients = Hash.new
    session
  end

  def session # Start session for a user
    default_user = "User"
    number_user = 0
    loop {
      Thread.start(@server.accept) do |client|

        # Confirm the chatroom password
        client.puts "Please type the password of this chatroom."
        message = client.gets.chomp
        try = 0
        until message == "intergouvernementalisations" || try == 2 do
          client.puts "Please retry"
          message = client.gets.chomp
          try+=1
        end
        if try == 2
          client.puts "quit"
        end

        # Create user
        nick_name = "#{default_user}" + "#{i+=1}"
        puts "Connection : #{nick_name} => #{client}"
        @connections_clients[client] = nick_name
        client.print(Time.now.ctime)
        client.puts " : Connection established! Happy chatting #{nick_name}!\nType /help to see all command-lines."
        listen_user_messages( client, nick_name )
      end
    }.join
  end

  def listen_user_messages( client, username ) # Receive messages from users
    loop {
      message = client.gets.chomp

      # Check command-lines
      if message == "/bye"
        bye_user( client, username )
      elsif message == "/list"
        list_user( client )
      elsif message =~ (/\A\/nick\s\w{3,10}/)
        change_user( client, username, message )
        username = @connections_clients[client]
      elsif message == "/help"
        client.puts "/bye : quit the server\n/list : list all users connected\n/nick your_username : choose your username"
      end

      # Send messages to users
      puts @connections_clients
      @connections_clients.each do |other_client, other_name|
        unless other_name == username || message =~ (/\A\/nick\s\w{3,10}/)
          other_client.puts "#{username}: #{message}"
        end
      end
    }
  end

end

Server.new('localhost', 8080)
