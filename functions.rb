#!/usr/bin/ruby -w
# Goodbye
def bye_user( client, username )
   puts "#{username} Goodbye friend !"
   client.puts "quit"
   @connections_clients.delete(client)
end

# Command /list
def list_user( client )
    client.puts @connections_clients.collect {|list_name| [list_name[1]]}
end

# Command /nick
def change_user( client, username, message )
    new_username = message.split(' ')[1]
    if new_username == username
      client.puts "Cet utilisateur existe déjà. Veuillez choisir un pseudonyme inexistant."
    else
      @connections_clients[client] = new_username
      client.puts "Félicitations, votre nouveau pseudonyme est : #{new_username}"

    end
end
