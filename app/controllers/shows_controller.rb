class ShowsController < ApplicationController

  get '/shows' do
    if logged_in?
      @shows = Show.all
      erb :'shows/shows'
    else
      redirect to '/login'
    end
  end

  get '/shows/new' do
    erb :'shows/create_show'
  end

  get '/shows/:id' do
    if logged_in?
      @show = Show.find_by_id(params[:id])
      erb :'shows/show_show'
    else
      redirect to '/login'
    end
  end

  post '/shows' do
    if logged_in?
      if params[:headliner] == "" || params[:date] == ""
        redirect to "/shows/new", locals: {message: "Please enter a valid headliner and date"}
      else
        binding.pry
        @show = current_user.shows.build(content: params[:content])
        if @show.save
          redirect to "/shows/#{@show.id}"
        else 
          redirect to "/shows/new"
        end 
      end
    else 
      redirect to '/login' 
    end
  end
    

end