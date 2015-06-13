require_relative 'entry.rb'
require 'csv'

class AddressBook
  attr_accessor :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone, email)
    index = 0
    @entries.each do |entry|
      name < entry.name ? break : index += 1
    end
    entries.insert(index, Entry.new(name, phone, email))
  end

  def remove_entry(entry)
    @entries.each { |e| @entries.delete(e) if e == entry }
  end

  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash['name'], row_hash['phone_number'], row_hash['email'])
    end
    return csv.count
  end

  def binary_search(name)
    lower = 0
    upper = entries.length - 1

    while lower <= upper
      mid = (lower + upper) / 2
      mid_name = entries[mid].name

      if mid_name == name
        return entries[mid]
      elsif name < mid_name
        upper = mid - 1
      elsif name > mid_name
        lower = mid + 1
      end
    end
  end

  def iterative_search(name)
    res = nil
    entries.each do |e|
      res = e if e.name == name
    end
    res
  end

end
