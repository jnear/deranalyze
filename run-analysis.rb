
if ARGV.length != 1 then
  abort("Error: requires one argument")
end

github_address = ARGV[0]
app_dir = github_address.split("/").last.split(".").first

# clone the repo
puts "Downloading #{github_address} into #{app_dir}..."
system ("git clone #{github_address}")
Dir.chdir app_dir

# append stuff to the gemfile
puts "Modifying the gemfile..."
no_sqlite = open('Gemfile', 'r') { |f| f.grep(/sqlite3/).empty? }


open('Gemfile', 'a') { |f|
  f.puts <<EOS

# Added by derailer analysis
gem 'derailer', :path => '/home/ubuntu/derailer'
gem 'method_source', "~>0.8.3", :git => 'https://github.com/aleksandarmilicevic/method_source.git'
gem 'sdg_utils', :git => 'https://github.com/jnear/sdg_utils.git'

EOS

  if no_sqlite then
    f.puts "gem 'sqlite3'"
  else
    f.puts "# sqlite already present"
  end
  f.puts ""
}

# make a new gemset for this app
# puts "Making a new gemset for #{app_dir}..."
# system "rvm gemset create #{app_dir}"
# system "rvm gemset use #{app_dir}"
# system "rvm gemset list"
# given up on gemsets

# install gems
puts "Running bundle install..."
system "bundle install"

# install our database.yml
puts "Installing database.yml..."
system "cp ../database.yml ./config/database.yml"

# now init the database
puts "Initializing database (rake db:migrate)..."
system "bundle exec rake db:migrate"

# now run the analysis
puts "Running analysis..."
system "bundle exec rake derailer"

# now copy the files into the results directory
system "time -o time.txt rake derailer > derailer_output.txt 2>&1"
system "cp -r /home/ubuntu/derailer/lib/derailer/viz ."

Dir.chdir ".."
