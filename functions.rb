# accepted connection
def run
  default_user = "User"
  i = 0
   loop{
      client_connection = @server_socket.accept
      Thread.start(client_connection) do |conn| # open thread for each accepted connection
         conn_name = "#{default_user}" + "#{i+=1}"
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

# Goodbye
def bye_user(message, username)
   puts "#{username} Goodbye friend !"
   puts @connected_clients[username]
   @connected_clients[username].puts 'quit'
   @connected_clients.delete(username)
end
