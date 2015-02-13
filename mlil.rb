require "pry"
require "./db/setup"
require "./lib/all"

puts "Running MyLifeInLists"


def add list_name, todo_item
  l = List.where(name: list_name).first_or_create!
  i = Item.create(name: todo_item, list_id: l.id)
end

def due item_id, date #Go back later and do either name, or Id
  date = DateTime.parse(date)
  Item.find_by(id: item_id).update(due_date: date)
end

# def done
#   Gif.create! views: 0, url: url
# end

# def show_list
#   Gif.order(created_at: :desc).each do |g|
#     puts "#{g.id})\t#{g.created_at}\t#{g.views}\t#{g.url}"
#   end
# end

# def show_incomplete
# end

# def show_all_items
# end

# def next tag_name=nil
#   tags = if tag_name
#     Tag.where(name: tag_name).first!
#   else
#     Tag.all
#   end
#   g = tag.gifs.order("RANDOM()").first

#   g.views += 1
#   g.save!
#   puts "Opening #{g.url}"
#   `open '#{g.url}'`
# end

# def search string
#   t = Tag.where(name: tag_name).first_or_create!
#   # Note: we're now verifying the gif_id is valid before saving a tag
#   Gif.find(gif_id).tags << t
# end

command = ARGV.shift
case command
when "add"
  list_name, todo_item = ARGV
  add list_name, todo_item
when "due" #FAIL
  item_id, date = ARGV
  due item_id, date
when "done" #FAIL
  n = ARGV
  done n
when "list" #FAIL
  show_incomplete
when "list" #FAIL
  listname = ARGV
  show_list listname
when "list all" #FAIL
  show_all_items
when "next" #FAIL
  tag_name = ARGV.first
  surprise! tag_name
when "search" #FAIL
  string = ARGV
  search string
else
  puts "???"
end
