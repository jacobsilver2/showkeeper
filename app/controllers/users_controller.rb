class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end


  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/users'
    end
  end

  get '/login' do 
    if !logged_in?
      erb :'users/login'
    else
      redirect '/shows'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/shows"
    else
      erb :'users/login', :locals => {:message => "Username or password is incorrect.  Please try again."}
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      erb :'users/create_user', :locals => {:message => "Please enter a valid username and password"}
    elsif User.find_by(username: params[:username])
    erb :'users/create_user', :locals => {:message => "That username is already taken.  Please try another!"}
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password], :venue => params[:venue])
      @user.save
      session[:user_id] = @user.id
      redirect to '/shows'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end



  
  
end
