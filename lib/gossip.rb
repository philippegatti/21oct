require 'pry'
require 'csv'

class Gossip
	attr_accessor :author
	attr_accessor :content

def initialize (author, content)
	@author = author
	@content = content
end

def save
  CSV.open("./db/gossip.csv", "ab") do |csv|
    csv << [@author,@content]
  end
end

def self.all
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

def self.save_update(updated_gossip,i)
		gossip_csv = []
		gossip_csv = CSV.table("./db/gossip.csv")
		puts "gossips avant changements"
		puts gossip_csv
		puts "gossip à modifier"
		puts gossip_csv[i-2] 
		gossip_csv[i-2] = [updated_gossip.author,updated_gossip.content]
		puts"gossips modifiés avant sauvegarde"
		puts gossip_csv
		File.open("./db/gossip.csv", 'w') do |f|
  			f.write(gossip_csv.to_csv)
		end
end
end