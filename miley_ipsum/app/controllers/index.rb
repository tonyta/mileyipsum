get '/' do
  erb :index
end

get '/ipsum' do
  Word.stanza + "<br><br>" + Word.stanza
end
