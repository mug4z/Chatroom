def chat_command
  puts
end
def run
   loop{
      client_connection = @server_socket.accept
      Thread.start(client_connection) do |conn| # open thread for each accepted connection
         conn_name = conn.gets.chomp
         if @connected_clients[conn_name]# avoid connection if user exits
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
