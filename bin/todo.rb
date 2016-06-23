require 'csv'
require_relative '../lib/app.rb'

todo = App.new
todo.welcome
todo.get_todo
# print CSV.read("data/todo_list.csv")
