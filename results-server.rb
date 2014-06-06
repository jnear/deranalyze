require 'fileutils'
require 'webrick'

root = File.expand_path(File.dirname(__FILE__))
cb = lambda do |req, res| 
  req.query[:dirs] = Dir["*/"]
  #req.query[:graph_string] = graph.to_s
  req.query[:rails_root] = req.path.to_s
  req.query[:log] = []
end

WEBrick::HTTPUtils::DefaultMimeTypes['rhtml'] = 'text/html'
server = WEBrick::HTTPServer.new :Port => 8003, :DocumentRoot => root, :RequestCallback => cb

trap 'INT' do server.shutdown end

server.start
