get '/' do
  erb :index
end

get '/ipsum' do
  lines = []
  4.times { lines << Word.ipsum }
  lines.join(',<br>') << '.'
end
