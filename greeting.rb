raise ArgumentError, 'Please supply some names' if ARGV.length < 1
ARGV.each do |name|
  puts "Hello #{name}"
end