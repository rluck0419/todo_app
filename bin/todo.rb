require 'csv'

class Todo
  def welcome
    system('clear')
    puts "Welcome to the Todo List."
  end

  def new_task?(input)
    input.to_i == 0
  end

  def tasks_from_file
    data = CSV.read("data/todo_list.csv", "r")
    data.map { |task| task.first }
  end

  def display_each_item(items)
    items.each do |item|
      todo_number = (items.index(item).to_i + 1).to_s
      puts "#{todo_number} - #{item}"
    end
  end

  def display_completed_items(items)
    puts "\ncompleted tasks: \n"
    items.each do |item|
      puts "- #{item}"
    end
  end

  def matches_index?(items, item, marked_index)
    items.index(item) == marked_index - 1
  end

  def number_too_high?(number, items)
    number.to_i > items.length
  end

  def number_in_range?(number, items)
    number.to_i <= items.length
  end

  def get_input
    puts "\nEnter a task number to mark as complete. Or, enter a new task."
    gets.chomp
  end

  def get_input_again
    puts "Sorry? Try another number. Or, enter a new task."
    gets.chomp
  end

  def get_todo
    tasks = tasks_from_file
    length = tasks.length
    completed = []

    display_each_item(tasks)

    while tasks.length > 0
      marked = get_input

      # loop for invalid input (number too high)
      if number_too_high?(marked, tasks)
        loop do
          marked = get_input_again
          break if number_in_range?(marked, tasks)
        end
      end

      # add a new task to list, or set 'marked' for marking a existing task as complete
      if new_task?(marked)
        tasks.push(marked)
        marked = marked.to_i
      else
        marked = marked.to_i
      end

      welcome

      tasks.each do |task|
        if tasks.length > length
          todo_number = (tasks.index(task).to_i + 1).to_s
          display_each_item(tasks)
          length += 1
          break
        end

        if matches_index?(tasks, task, marked)
          # completed = completed.push(tasks[marked-1])

          completed.push(tasks.delete_at(marked - 1))
          length -= 1

          todo_number = (tasks.index(task).to_i + 1).to_s
          display_each_item(tasks)
        end
      end

      display_completed_items(completed)
    end
  end
end

todo = Todo.new
todo.welcome
todo.get_todo
# print CSV.read("data/todo_list.csv")
