#!/usr/bin/env ruby
# accepted connection
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

# Command /list
def list_username(username, message)
    if message == "/list"
          @connected_clients[username].puts @connected_clients.collect {|list_name| [list_name[0]]}
    end
end

# Command /nick
def change_username(username, message)
  if message =~ (/\A\/nick\s\w{3,10}/)
    new_username = message.split(' ')[1]
    if @connected_clients[new_username]
      @connected_clients[username].puts "Cet utilisateur existe déjà. Veuillez choisir un pseudonyme inexistant."
    else
      @connected_clients[username].puts "Félicitations, votre nouveau pseudonyme est : #{username}"
    end
  end
end

# Goodbye
def bye_user(message, username)
   puts "#{username} Goodbye friend !"
   puts @connected_clients[username]
   @connected_clients[username].puts 'quit'
   @connected_clients.delete(username)
   
end
