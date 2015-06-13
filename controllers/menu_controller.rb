require_relative '../models/address_book'

class MenuController
  attr_accessor :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    system 'clear'
    puts "Main Menu - #{@address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - View user by position"
    puts "6 - Detonate!"
    puts "7 - Exit"
    print "Enter your selection: "
    selection = gets.to_i

    case selection
    when 1
      system 'clear'
      view_all_entries
      main_menu
    when 2
      system 'clear'
      create_entry
      main_menu
    when 3
      system "clear"
      search_entries
      main_menu
    when 4
      system "clear"
      read_csv
      main_menu
    when 5
      system 'clear'
      find_user_by_position
    when 6
      system 'clear'
      detonate
    when 7
      puts "Good-bye!"
      exit(0)
    else
      system 'clear'
      puts 'Sorry, that is not a valid option'
      main_menu
    end
  end

  def view_all_entries
    @address_book.entries.each do |entry|
      system 'clear'
      puts entry.to_s
      entry_submenu(entry)
    end

    system 'clear'
    puts 'End of entries'
  end
 
  def create_entry
    system 'clear'
    puts 'New AddressBloc Entry'

    print 'Name: '
    name = gets.chomp

    print 'Phone Number: '
    phone = gets.chomp

    print 'Email: '
    email = gets.chomp

    @address_book.add_entry(name, phone, email)

    system 'clear'
    puts "New entry created"
  end

  def entry_submenu(entry)
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
 
    selection = gets.chomp
 
    case selection
    when "n"
    when "d"
      delete_entry(selection)
    when "e"
      edit_entry(selection)
      entry_submenu(entry)
    when "m"
      system 'clear'
      main_menu
    else
      system 'clear'
      puts "#{selection} is not a valid input"
      entries_submenu(entry)
    end
  end

  def find_user_by_position
    system 'clear'
    puts "Enter the position of the user: "
    position = gets.chomp.to_i
    user = @address_book.entries[position]
    if user.nil?
      puts 'No results found'
    else
      puts "Results:  #{user.to_s}"
    end
    puts 'Hit enter to return to main menu'
    while keystroke = gets
      main_menu if keystroke == "\n"
    end
  end
  
  def search_entries
    print 'Search by name: '
    query = gets.chomp
    result = @address_book.iterative_search(query)
    system 'clear'
    if result
      puts "Result: #{result.to_s}"
      search_submenu(result)
    else
      puts "No results for #{query}"
      sleep(2)
      main_menu
    end
  end

  def search_submenu(entry)
    puts "d - delete entry"
    puts "e - edit entry"
    puts "m - return to main menu"

    selection = gets.chomp

    case selection
    when 'd'
      system 'clear'
      delete_entry(entry)
      main_menu
    when 'e'
      edit_entry(entry)
      system 'clear'
      main_menu
    when 'm'
      system 'clear'
      main_menu
    else
      system 'clear'
      puts "#{selection} is not a valid option"
      puts entry.to_s
      search_submenu(entry)
    end
  end
 
  def read_csv
    print 'Enter CSV file to import: '
    file_name = gets.chomp

    if file_name.empty?
      system 'clear'
      puts "No CSV file read"
      main_menu
    end

    begin
      entry_count = @address_book.import_from_csv(file_name)
      system 'clear'
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is nae a valid CSV file, please try again or hit enter to return to the main menu"
      # while keystroke = gets
      #   main_menu if keystroke == "\n"
      # end
      read_csv
    end
  end

  def delete_entry(entry_name)
    @address_book.entries.delete(entry_name)
    puts "#{entry_name} has been deleted"
  end

  def detonate(entry=nil)
    system 'clear'
    print 'Do you really want to destroy all entries?  Enter y/Y to confirm'
    response = gets.chomp
    if %w(y Y).include?(response)
      @address_book.entries.each { |e| delete_entry(e) }
      system 'clear'
      print 'Detonated!'
      sleep(2)
      main_menu
    else
      print 'Invalid entry, please try again or enter m/M to return to main menu'
      response = gets.chomp
      if %w(m M).include?(response)
        system 'clear'
        main_menu
      else
        detonate(response)
      end
    end
  end

  def edit_entry(entry)
    print 'Updated name: '
    name = gets.chomp
    print 'Updated phone number: '
    phone_number = gets.chomp
    print 'Updated email: '
    email = gets.chomp

    # %w(name phone_number email).each do |attribute|
    #   entry.instance_variable_set(attribute.to_sym, attribute) if attribute
    # end
    entry_name = name if name
    entry.phone_number = phone_number if phone_number
    entry.email = email if email
    system 'clear'

    puts 'Updated entry: '
    puts entry.to_s

  end
  
end