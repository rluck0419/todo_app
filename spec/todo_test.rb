require 'minitest/autorun'
require 'minitest/pride'
require_relative '../bin/todo.rb'

class TodoTest < Minitest::Test
  def todo
    ::Todo.new
  end

  def test_todo_exists
    assert todo
  end

  def test_welcome_msg
    # fails if todo.welcome contains "puts"
    assert_equal "Welcome to the Todo List.", todo.welcome
  end

  def test_task_added
    assert_equal '1 - Do some stuff.', CSV.read("data/todo_list.csv", "r").join(' ')
  end
end
