#!/usr/bin/ruby -w

def bye_user( client, username ) # Goodbye
   puts "#{username} Goodbye friend !"
   client.puts "quit"
   @connections_clients.delete(client)
end

def list_user( client ) # Command /list
    client.puts @connections_clients.collect {|list_name| [list_name[1]]}
end

def change_user( client, username, message ) # Command /nick
    new_username = message.split(' ')[1]
    if new_username == username
      client.puts "Cet utilisateur existe déjà. Veuillez choisir un pseudonyme inexistant."
    else
      @connections_clients[client] = new_username
      client.puts "Félicitations, votre nouveau pseudonyme est : #{new_username}"
    end
end
