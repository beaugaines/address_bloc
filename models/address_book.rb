require_relative 'entry.rb'
require 'csv'
require 'pstore'

class AddressBook
  attr_accessor :entries

  def initialize
    @entries = PStore.new('data.pstore')
  end

  def all
    entries.transaction { entries.roots }
  end

  def find(email)
    entries.transaction do
      entries.fetch(email, 'No records found')
    end
  end

  def create(name, phone, email)
    entries.transaction do
      if entries[email] = Entry.new(name, phone, email)
        puts "New record added to list for #{email}"
      else
        puts 'There was an error creating your record'
      end
    end
  end

  def update(entry)
    entries.transaction do
      if record = entries[entry.email]
        entries[entry.email] = entry
      else
        puts "No record found"
      end
    end
  end

  def destroy(entry)
    entries.transaction do
      if entries.delete(entry)
        puts "#{entry} deleted from list"
      end
    end
  end

  def entry_count
    entries.transaction { entries.roots.count }
  end

  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      row_hash = row.to_hash
      create(row_hash['name'], row_hash['phone_number'], row_hash['email'])
    end
    return csv.count
  end

end
