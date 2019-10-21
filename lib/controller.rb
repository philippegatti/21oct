require 'gossip'

class ApplicationController < Sinatra::Base
  
  get '/' do #affiche la page principale
	erb :index, locals: {gossips: Gossip.all}
  end
  
  get '/gossips/new/' do #affiche la page de création d'un nouveau gossip
    erb :new_gossip
  end
  
  get '/gossips/:id' do #affiche la page d'un gossip donné
  	erb :show, locals: {gossip: Gossip.find(params["id"].to_i), id: params["id"]}
  end

  post '/gossips/new/' do #récupère les informations et crée un nouveau gossip
  	Gossip.new(params["gossip_author"],params["gossip_content"]).save
  	redirect '/'
  end

  get '/gossips/:id/edit/' do #affiche la page permettant de modifier un gossip
  	erb :edit, locals: {gossip: Gossip.find(params["id"].to_i), id: params["id"]}
  end

  post '/gossips/:id/edit/' do #recupère les infos et modifie le gossip
  	gossip_updated = Gossip.all[params["id"].to_i-1].update(params["gossip_author"],params["gossip_content"]) # on modifie les variables de l'instance gossip
  	Gossip.save_update(gossip_updated,params["id"].to_i) #on enregistre les changements dans la bdd
  	redirect '/'
  end


end