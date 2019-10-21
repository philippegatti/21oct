require 'pry'
require 'csv'

class Gossip
	attr_accessor :author
	attr_accessor :content

def initialize (author, content)
	@author = author
	@content = content
end

def save #sauvegarde d'un gossip dans le csv
  CSV.open("./db/gossip.csv", "ab") do |csv|
    csv << [@author,@content]
  end
end

def self.all #recensement de tous les gossips
  all_gossips = []
  CSV.read("./db/gossip.csv").each do |csv_line|
    all_gossips << Gossip.new(csv_line[0], csv_line[1])
  end
  return all_gossips
end

def self.find(id)
	return self.all[id-1]
end

def update(author, content)
	@author = author
	@content = content
	return self
end

def self.save_update(updated_gossip,i) #enregistrement du gossip modifié
		gossip_csv = []
		gossip_csv = CSV.table("./db/gossip.csv")
		gossip_csv[i-2] = [updated_gossip.author,updated_gossip.content]
		File.open("./db/gossip.csv", 'w') do |f|
  			f.write(gossip_csv.to_csv)
		end
end
end