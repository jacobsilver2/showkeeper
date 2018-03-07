require 'pry'
class ShowsController < ApplicationController

  get '/shows' do
    if logged_in?
      @shows = current_user.shows
      if @shows.empty?
        erb :'shows/shows', locals: {message: "There are currently no shows in the database"}
      else
        erb :'shows/shows'
      end
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

  get '/shows/:id/edit' do
    if logged_in?
      @show = Show.find_by_id(params[:id])
      if @show && @show.user == current_user
        erb :'shows/edit_show'
      else
        redirect to '/shows'
      end
    else
      redirect to '/login'
    end
  end

  post '/shows' do
    if logged_in?
      if params[:headliner] == "" || params[:date] == ""
        redirect to "/shows/new", locals: {message: "Please enter a valid headliner and date"}
      else
        @show = current_user.shows.build(date: params[:date], headliner: params[:headliner], headliner_url: params[:headliner_url], doors_at: params[:doors_at], support: params[:support], blurb: params[:blurb])
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

  patch '/shows/:id' do
    if logged_in?
      if params[:date] == "" || params[:headliner] == ""
        redirect to "/shows/#{params[:id]}/edit"
      else
        @show = Show.find_by_id(params[:id])
        if @show && @show.user == current_user
          if @show.update(headliner: params[:headliner])
            redirect to "/shows/#{@show.id}"
          else 
            redirect to "/shows/#{@show.id}/edit"
          end
        else 
          redirect to '/shows'
        end
      end
    else 
      redirect to '/login'
    end
  end


  delete '/shows/:id/delete' do
    if logged_in?
      @show = Show.find_by_id(params[:id])
      if @show && @show.user == current_user
        @show.delete
      end
      redirect to '/shows'
    else
      redirect to '/login'
    end
  end
    

end