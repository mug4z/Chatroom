require 'socket'
class Server
   def initialize(socket_address, socket_port)
      @server_socket = TCPServer.open(socket_port, socket_address)
      @connected_clients = Hash.new
      puts 'Started server.........'
      run
   end
   def run
      loop{
         client_connection = @server_socket.accept
         Thread.start(client_connection) do |conn| # open thread for each accepted connection
            conn_name = conn.gets.chomp.to_sym
            if @connected_clients[conn_name] # avoid connection if user exits
               conn.puts "This username already exist"
               conn.puts "quit"
               conn.kill self
            end
            puts "Connection established #{conn_name} => #{conn}"
            @connected_clients[conn_name] = conn
            conn.puts "Connection established successfully #{conn_name} => #{conn}, you may continue with chatting....."
            establish_chatting(conn_name, conn) # allow chatting
         end
      }.join
   end
   def establish_chatting(username, connection)
      loop do
         message = connection.gets.chomp
         puts @connected_clients
         (@connected_clients).keys.each do |client|
            @connected_clients[client].puts "#{username} : #{message}"
         end
      end
   end
end
Server.new( 8080, "localhost" )
