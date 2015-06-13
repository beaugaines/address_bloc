require_relative '../models/address_book'

def benchmark(label=nil)
  puts label unless label.nil?
  before = Time.now
  yield
  after = Time.now
  puts "Took %.3fs" % (after - before)
end

a = AddressBook.new
a.import_from_csv('../entries.csv')

benchmark('Binary search') do
  100000.times do
    a.binary_search('Guy')
  end
end

benchmark('Iterative search') do
  100000.times do
    a.iterative_search('Guy')
  end
end
