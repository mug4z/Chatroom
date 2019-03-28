#!/usr/bin/ruby
require 'socket'                 # Get sockets from stdlib
require './functions'
class Server

  def initialize( ip, port )
    @server = TCPServer.open( ip, port )
    @connections_clients = Hash.new
    run
  end

  def run
    default_user = "User"
    i = 0
    loop {
      Thread.start(@server.accept) do |client|
        client.puts "Please type the password of this chatroom."
        message = client.gets.chomp
        n = 0
        until message == "1234" || n == 2 do
          client.puts "Please retry"
          message = client.gets.chomp
          n+=1
        end
        if n == 2
          client.puts "quit"
        end
        nick_name = "#{default_user}" + "#{i+=1}"
        puts "Connection : #{nick_name} => #{client}"
        @connections_clients[client] = nick_name
        client.print(Time.now.ctime)
        client.puts " : Connection established! Happy chatting #{nick_name}!\nType /help to see all command-lines."
        listen_user_messages( client, nick_name )
      end
    }.join
  end

  def listen_user_messages( client, username )
    loop {
      message = client.gets.chomp
      if message == "/bye"
        bye_user( client, username )
      elsif message == "/list"
        list_user( client )
      elsif message =~ (/\A\/nick\s\w{3,10}/)
        change_user( client, username, message )
        username = @connections_clients[client]
      elsif message == "/help"
        client.puts "/bye : quit the server\n/list : list all user connected\n/nick your_username : choose your username"
      end
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
