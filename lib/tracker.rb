require 'pry'
require 'csv'
require 'date'

def make_new_table(input_csv)
  keep = ["Amount", "Posting Date", "Description"]
  input_table = CSV.read(input_csv, headers:true) 
  new_table = input_table.by_col!.delete_if { |name, values| !keep.include? name } 
  new_table.to_csv
end 

def parse_input_csv(input_csv, statement_array)
  # puts 'hi from parse method'
  CSV.parse(input_csv, headers: true) do | row | 
    puts row["Posting Date"]
    puts row["Description"]
    puts row["Amount"]
    puts "Is this a shared expense? y/n"
    if shared_expense? == "y"
      statement_array << row.to_h 
      puts "added to sheet"
    end 
  end
  return statement_array
end 

def shared_expense? 
  # puts 'hi from shared expenses?'
  answer = $stdin.gets.chomp
  if answer == "y"
    return "y"
  elsif answer == "n"
    puts "Ok I won't add this"
    return "n"
  else 
    puts "please answer y or n"
    shared_expense?
  end 
end 

def write_new_file(statement_array, output)
  # puts 'hi from writer method'
  CSV.open(output, "wb") do | csv |
    csv << ["Amount", "Date", "Description"]
    statement_array.each do | expense | 
        csv << expense.values
    end 
  end 
  'your shared expense sheet has been created!'
  output
end 

def run(input_csv, output) 
  # puts 'hi from run'
  statement_array = []
  table_to_parse = make_new_table(input_csv)
  parse_input_csv(table_to_parse, statement_array)
  write_new_file(statement_array, output)
end 