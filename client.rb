#!/usr/bin/ruby -w
require 'socket' # Sockets are in standard library

class Client
  def initialize( connection )
    @server = connection
    @request = send
    @receive = listen
    @request.join # Send messages to server
    @receive.join # Receive messages from server
  end

  def listen # Receive messages from server
    Thread.new do
      loop {
        message = @server.gets.chomp
        puts "#{message}"
        if message == "quit"
          @server.close
          exit
        end
      }
    end
  end

  def send # Send messaqges to server
    Thread.new do
      loop {
        message = $stdin.gets.chomp
        @server.puts( message )
      }
    end
  end

end

connection = TCPSocket.open('172.17.102.141', 8080)
Client.new( connection )
