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

  def listen
    Thread.new do
      loop {
        message = @server.gets.chomp
        puts "#{message}"
      }
    end
  end

  def send
    puts "Please enter your username to establish a connection :"
    Thread.new do
      loop {
        message = $stdin.gets.chomp
        @server.puts( message )
      }
    end
  end
  
end

connection = TCPSocket.open('localhost', 8080)
Client.new( connection )
