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

#puts repos

repos.each do |r|
  system "ln -s /home/ubuntu/deranalyze/repos/#{r} exp-repos/#{r}"  
end

