<<<<<<< HEAD
require 'socket'
require './functions'
class Client
   def initialize(socket)
      @socket = socket
      @request_object = send_request
      @response_object = listen_response
      @request_object.join # will send the request to server
      @response_object.join # will receive response from server
   end

   def send_request
      begin
          Thread.new do
            loop do
                message = $stdin.gets.chomp
                @socket.puts message
            end
         end
      rescue IOError => e
         puts e.message
         # e.backtrace
         @socket.close
       end
    end

   def listen_response
      begin
         Thread.new do
            loop do
               response = @socket.gets.chomp
               puts "#{response}"
               if response.eql?'quit'
                  @socket.close
                  exit
               end
            end
         end
      rescue IOError => e
         puts e.message
         # e.backtrace
         @socket.close
      end
   end
  end
socket = TCPSocket.open( "localhost", 8080 )
Client.new( socket )
=======
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
>>>>>>> master
