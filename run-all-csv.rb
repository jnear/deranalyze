require 'csv'

if ARGV.length != 1 then
  abort("Error: requires one argument")
end

csv_file = ARGV[0]

arr_of_arrs = CSV.read(csv_file)
arr_of_arrs.shift

seen_names = []
results = []

arr_of_arrs.each do |row|
  name,url,watchers = row
  next if seen_names.include? name
  results << url
  seen_names << name
end

puts results.length
#puts results
