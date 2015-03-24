def run_analysis(app_dir)
  # append stuff to the gemfile
  puts "Modifying the gemfile..."
  not_modified = open('Gemfile', 'r') { |f| f.grep(/derailer/).empty? }

  if not_modified then
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
  else
    puts "Gemfile already modified"
  end

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
  system "cp ../../database.yml ./config/database.yml"

  # now init the database
  puts "Initializing database (rake db:migrate)..."
  system "bundle exec rake db:migrate"

  # now run the analysis & copy files
  puts "Running analysis..."
  system "rm /home/ubuntu/derailer/lib/derailer/viz/constraint_graph.json"
  system "rm /home/ubuntu/derailer/lib/derailer/viz/saves.json"

  system "time -o time.txt bundle exec rake derailer > derailer_output.txt 2>&1"
  system "cp -r /home/ubuntu/derailer/lib/derailer/viz ."

end

dirs = Dir["*/"]

total_dirs = dirs.length
current_dir = 1

dirs.each do |dir|
  puts "WORKING ON #{dir} (this is number #{current_dir} of #{total_dirs})"
  current_dir = current_dir + 1
  puts "Current Dir is #{Dir.pwd}"
  Dir.chdir dir

  puts "After chdir, Current Dir is #{Dir.pwd}"

  begin
    run_analysis(dir)
  rescue => msg
    puts "ERROR with #{dir}: #{msg}"
  end
  puts "DONE WITH #{dir}"
  Dir.chdir ".."
end
