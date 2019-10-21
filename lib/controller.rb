require 'gossip'

class ApplicationController < Sinatra::Base
  
  get '/' do
	erb :index, locals: {gossips: Gossip.all}
  end
  
  get '/gossips/new/' do
    erb :new_gossip
  end
  
  get '/gossips/:id' do
  	erb :show, locals: {gossip: Gossip.find(params["id"].to_i), id: params["id"]}
  end

  post '/gossips/new/' do
  	Gossip.new(params["gossip_author"],params["gossip_content"]).save
  	redirect '/'
  end

  get '/gossips/:id/edit/' do
  	erb :edit, locals: {gossip: Gossip.find(params["id"].to_i), id: params["id"]}
  end

  post '/gossips/:id/edit/' do
  	gossip_updated = Gossip.all[params["id"].to_i-1].update(params["gossip_author"],params["gossip_content"])
  	Gossip.save_update(gossip_updated,params["id"].to_i)
  	redirect '/'
  end


end