require_relative '../models/address_book'
require 'ffaker'

def benchmark(label=nil)
  puts label unless label.nil?
  before = Time.now
  yield
  after = Time.now
  puts "Took %.3fs" % (after - before)
end

a = AddressBook.new
# a.import_from_csv('../entries.csv')
# a.destroy_all

10000.times do
  a.add_entry(FFaker::Name.name,
    FFaker::PhoneNumber.phone_number,
    FFaker::Internet.email)
end

a.add_entry('Bob', '123-456-7890', 'bob@dobbs.com')



benchmark('Binary search') do
  10000.times do
    a.binary_search('Guy')
  end
end

benchmark('Iterative search') do
  10000.times do
    a.iterative_search('Guy')
  end
end

# Results:
#  Binary search
#    Took 0.032s
#  Iterative search
#    Took 13.043s