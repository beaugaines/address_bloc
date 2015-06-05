require_relative 'entry.rb'

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

end
