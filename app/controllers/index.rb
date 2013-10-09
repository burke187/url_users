enable :sessions

get '/users/:id' do
  if current_user
    erb :user_page
  else
    erb :index
  end
end


get '/' do
  erb :index
end

get '/create' do
  erb :create
end

post '/create' do
 user = User.create(params[:creation])
 session[:user_id] = user.id
 current_user
 redirect("/users/#{@current_user.id}")
end

post '/' do
  if params[:logout]
    session[:user_id] = nil
    @current_user = nil
    erb :index
  elsif params[:email] && params[:password]
    authentication = User.authenticate(params[:email], params[:password])
    if authentication
      session[:user_id] = authentication.id
      current_user
      redirect("/users/#{authentication.id}")
    else
      redirect('/')
    end
  end
end

#####################################################

post '/urls' do
  Url.create(link: params[:link])
  redirect('/')
end

get '/:short_link' do
  url_object = Url.where('short_link=?', params[:short_link])
  if url_object != []
    redirect("#{url_object[0].link}")
  else
    redirect("/")
  end
end
