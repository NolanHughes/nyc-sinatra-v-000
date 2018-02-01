class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(name: params[:figure][:name])

    if title = Title.find_by_id(params[:figure][:title_ids])#fix for multiple titles?
      @figure.titles << title
    else
      title = Title.create(name: params[:figure][:new_title])
      @figure.titles << title
    end

    if landmark = Landmark.find_by_id(params[:figure][:landmark_ids])#fix for multiple landmarks?      figure.titles << title
      @figure.landmarks << landmark
    else
      landmark = Landmark.create(name: params[:figure][:new_landmark])
      @figure.landmarks << landmark
    end

    erb :'/figures/show'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])

    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    @landmarks = @figure.landmarks

    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    landmark = Landmark.create(name: params[:figure][:new_landmark])
    @figure.name = params[:figure][:name]
    @figure.landmarks << landmark
    @figure.save

    erb :'figure/show'
  end

end
