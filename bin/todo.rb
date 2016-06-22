require 'csv'

class Todo
  def welcome
    system('clear')
    puts "Welcome to the Todo List."
  end

  def get_todo
    tasks = CSV.read("data/todo_list.csv", "r")
    tasks = tasks.map { |task| task.first }
    length = tasks.length
    completed = []

    tasks.each do |task|
      todo_number = (tasks.index(task).to_i + 1).to_s
      puts "#{todo_number} - #{task}"
    end

    while tasks.length > 0

      puts "\nEnter a task number to mark as complete. Or, enter a new task."
      marked = gets.chomp
      if marked.to_i == 0
        tasks.push(marked)
        marked = marked.to_i
      else
        marked = marked.to_i
      end

      welcome

      # todo_number = "1"
      # tasks.each do |new_tasks|
        # puts "#{todo_number} - #{new_tasks}"
        # todo_number = (todo_number.to_i + 1).to_s
      # end

      tasks.each do |task|
        if tasks.index(task) == marked - 1
          # completed = completed.push(tasks[marked-1])

          completed.push(tasks.delete_at(marked - 1))

          todo_number = (tasks.index(task).to_i + 1).to_s
          tasks.each do |new_tasks|
            puts "#{todo_number} - #{new_tasks}"
            todo_number = (todo_number.to_i + 1).to_s
          end

        elsif tasks.length > length
          todo_number = (tasks.index(task).to_i + 1).to_s
          tasks.each do |new_tasks|
            puts "#{todo_number} - #{new_tasks}"
            todo_number = (todo_number.to_i + 1).to_s
          end
          break
        end
      end

      puts "\ncompleted tasks: \n"
      completed.each do |something|
        # if tasks[0].length > 1
        #   puts "- #{task[0]}"
        # else
          puts "- #{something}"
        # end
      end
    end
  end
end

todo = Todo.new
todo.welcome
todo.get_todo
# print CSV.read("data/todo_list.csv")
