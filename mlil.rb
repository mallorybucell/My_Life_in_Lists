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

def done item_id #Go back later and do either name, or Id
  Item.find_by(id: item_id).update(status: "Complete")
end

def show_specific thing=nil
  if thing == "all"
    x = Item.all
    x.each do |p|
      print "Id: #{p.id}, Task name: #{p.name}, Status: #{p.status}" #from #{list_id.name}"
      puts
    end
  else
    y = List.where(name: thing)
    y = y.first.id
    x = Item.where(list_id: y)
    x.each do |p|
      puts "Id: #{p.id}, Task name: #{p.name}, Status: #{p.status}" #from #{list_id.name}"
    end
  end
end

def show_incomplete
  #fix so show list belong to as well
  x = Item.where(status: "Incomplete") 
  x.each do |p|
    puts "Id: #{p.id}, Task name: #{p.name}" #from #{list_id.name}"
  end
end

def next_item
  if task = Item.where.not(due_date: 0)
    t = task.order("RANDOM()").first
  else   
    task = Item.all
    t = task.order("RANDOM()").first
  end
  print "Id: #{t.id}, Task name: #{t.name}, Status: #{t.status}"
  puts
end

def search string
  task_match = []
  task = Item.find_each do |m| 
    if m.name.match(string) #|| m.description.match(string) (default this not to nil or write rescue)
        puts "Id: #{m.id} Name: #{m.name}" 
    else
      next
    end
  end
end

command = ARGV.shift
case command
when "add"
  list_name, todo_item = ARGV
  add list_name, todo_item
when "due"
  item_id, date = ARGV
  due item_id, date
when "done"
  n = ARGV
  done n
when "list"
  thing = ARGV.shift
  if !(thing == nil)
    show_specific thing
  else
    show_incomplete
  end
when "next"
  next_item
when "search" #FAIL
  string = ARGV.shift.to_s
  search string
else
  puts "???"
end
