enable :sessions

get '/' do
  erb :index
end

post '/create' do
 user = User.create(params[:creation])
 session[:user] = user
 redirect('/secret')
end

get '/secret' do
  if session[:user]
    erb :secret
  else
    erb :index
  end
end

post '/' do
  if params[:logout]
    session[:user] = nil
    erb :index
  elsif params[:email] && params[:password]
    authentication = User.authenticate(params[:email], params[:password])
    if authentication
      session[:user] = authentication
      redirect('/secret')
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
