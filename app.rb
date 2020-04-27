
require 'sinatra'
require 'sinatra/reloader'
require 'pg'

client = PG::connect(
  :host => "localhost",
  :user => 'k', :password => '',
  :dbname => "cotoba")

get '/test' do
  erb :test
end



get '/lyrics' do
  erb :index
end




post '/word' do
  @name = params[:name]
  @pass = params[:pass]
  @word = params[:word]

  if @name=="" or @pass==""
    erb :index
  elsif @name and @pass 
    get_posts_query = "SELECT * from users where name='#{@name}' and pass='#{@pass}'"
    @users = client.exec_params(get_posts_query);
    # "<h1>Hello #{@users[0]["name"]}!#{@users[0]['pass']}</h1>"
    erb:new_music
  elsif @word==""
    get_posts_query = "SELECT * from word WHERE word LIKE '% %'"
    @words = client.exec_params(get_posts_query);
    @word=" "

    erb:word
  elsif @word
    get_posts_query = "SELECT * from word WHERE word LIKE '%#{@word}%'"
    @words = client.exec_params(get_posts_query);

    erb:word
  end
end

get '/new_user' do
    erb:new_user
end

post '/new_user' do
  @name = params[:name]
  @pass = params[:pass]


  insert_query = """
  INSERT INTO
    users (name, pass)
  VALUES
    ($1,$2)
  """
  client.exec_params(insert_query, [@name,@pass]);
  # redirect to('/index')
  erb:index
end


post '/new_music/:id' do
  @id = params[:id]
  @music_name = params[:music_name]
  @artist= params[:artist]
  @url = params[:url]
  @word =params[:word]


  insert_query = """
  INSERT INTO
    music (name,artist,url)
  VALUES
    ($1,$2,$3)
  """
  client.exec_params(insert_query, [@music_name,@artist,@url])
  # redirect to('/index')

  get_posts_query = "SELECT * from music WHERE name='#{@music_name}'"
    @musics = client.exec_params(get_posts_query);

  insert_query = """
  INSERT INTO
    word (user_id,music_id,word)
  VALUES
    ($1,$2,$3)
  """
  client.exec_params(insert_query, [@id,@musics[0]['id'],@word]);

  redirect '/music/'+@musics[0]['id'];
end


# APIとしてクエリしたデータをJSONで返す
get '/2' do
  get_posts_query = "SELECT * from music"
  @musics = client.exec_params(get_posts_query);
  ary = Array.new
  @musics.each {|row| ary << row}
  # content_type :json
  @date1=ary.to_json
end

get '/getword/:word' do
  get_posts_query = "SELECT * from word WHERE word LIKE '%#{params[:word]}%'"
  @words = client.exec_params(get_posts_query);
  ary = Array.new
  @words.each {|row| ary << row}
  # content_type :json
  @date1=ary.to_json
end

get '/get_music_word/:id' do
  get_posts_query = "SELECT * from word WHERE music_id ='#{params[:id]}'"
  @words = client.exec_params(get_posts_query);
  ary = Array.new
  @words.each {|row| ary << row}
  # content_type :json
  @date1=ary.to_json
end



#/music

get '/music/:music_id' do

  get_posts_query = "SELECT * from music WHERE id = '#{params[:music_id]}'"
  @musics = client.exec_params(get_posts_query);

  get_posts_query = "SELECT * from word WHERE music_id = '#{params[:music_id]}'"
  @words = client.exec_params(get_posts_query);

  # get_posts_query = "SELECT * from lyrics WHERE music_id = '#{params[:music_id]}'"
  # @lyrics = client.exec_params(get_posts_query);

  @music_id=params[:music_id];
  @word="null";
  erb:music

end






# app.rb
get '/index' do

    get_posts_query = "SELECT * from users"
    @users = client.exec_params(get_posts_query);

    get_posts_query = "SELECT * from music"
    @musics = client.exec_params(get_posts_query);

    get_posts_query = "SELECT * from word"
    @words = client.exec_params(get_posts_query);

    get_posts_query = "SELECT * from lyrics"
    @lyrics = client.exec_params(get_posts_query);

    @blue=20;
    erb :index1
  end



post '/post' do
    @name = params[:name]
    @pass = params[:pass]


    insert_query = """
    INSERT INTO
      users (name, pass)
    VALUES
      ($1,$2)
    """
    client.exec_params(insert_query, [@name,@pass])
    # redirect to('/index')
    erb :post
end
