require_relative 'fake_sinatra'

get '/about_me' do
	body = ['Hello World']
	[200, {"Content-Type" => "text/html"}, body]
end

app = lambda do |env|
	body = File.open("#{File.dirname(__FILE__)}/404.html", "r")
	[404, {"Content-Type" => "text/html"}, body]
end

run app