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



rails_apps = 0
results.each do |url|
  r1,r2 = url.split("https://")
  system "git clone https://anonymous:anonymous@#{r2}.git > /dev/null 2>&1"
  dir = url.split("/").last

  if File.exist?("#{dir}/app")
    # then it's a rails app
    puts "IS a rails app: #{dir}"
  else
    # not a rails app
    puts "NOT a rails app: #{dir}"
    system "rm -rf #{dir} > /dev/null"
  end
end

puts "we got #{rails_apps} rails apps"
