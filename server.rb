#!/usr/bin/ruby
require 'socket'                 # Get sockets from stdlib

class Server

  def initialize( ip, port )
    @server = TCPServer.open( ip, port )
    @connections_clients = Hash.new
    run
  end

  def run
    loop {
      Thread.start(@server.accept) do |client|
        nick_name = client.gets.chomp
        @connections_clients.each do |other_client, other_name|
          if client == other_client || nick_name == other_name
            client.puts "This username already exist"
            Thread.kill self
          end
        end
        puts "Connection : #{nick_name} => #{client}"
        @connections_clients[client] = nick_name
        client.print(Time.now.ctime)
        client.puts " : Connection established! Happy chatting!"
        #client.close                  # Disconnect from the client
        listen_user_messages( client, nick_name )
      end
    }.join
  end

  def listen_user_messages( client, username )
    loop {
      message = client.gets.chomp
      puts @connections_clients
      @connections_clients.each do |other_client, other_name|
        unless other_name == username
          other_client.puts "#{username}: #{message}"
        end
      end
    }
  end

end

Server.new('localhost', 8080)
