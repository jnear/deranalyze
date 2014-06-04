file = File.open("new-repo-urls.txt")

file.each do |url|
  puts "Working on #{url}"
  str = "git clone #{url}"
  system "ruby run-analysis.rb #{url}"
end
