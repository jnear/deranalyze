repos = [
"rails3-bootstrap-devise-cancan",
"fb_graph_sample",
"jquery-fileupload-rails-paperclip-example",
"ember-auth-rails-demo",
"ember-rails-devise-demo",
"sportbook",
"rails_container_and_engines",
"TOT2",
"bootstrap-rails-startup-site",
"furatto-rails-start-kit",
"postgis-on-rails-example",
"jqm-rails",
"rails-4-landing",
"redport",
"league-tutorial",
"requirejs-rails-jasmine-template",
"grinch",
"rails-angularjs-example",
"railscrm-advanced",
"dreamy",
"tada-ember",
"ribbit",
"test-signet-rails",
"yelp",
"world.db.admin",
"MediumClone",
"permissions",
"rails-devise-backbone-auth",
"geochat-rails",
"rails-api-authentication"
]

repos = ["ribbit"]

repos.each do |r|
  time = `cat #{r}/time.txt`
  total_time = time.split(" ")[0].gsub("user", "").to_f + time.split(" ")[1].gsub("system", "").to_f
  
  exposures = `grep 'NUMBER OF EXPOSU' #{r}/derailer_output.txt`
  num_exposures = exposures.split(" ")[3]

  puts "#{r},#{total_time},#{num_exposures}"
end
