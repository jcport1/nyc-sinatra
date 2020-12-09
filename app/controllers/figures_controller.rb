class FiguresController < ApplicationController
  # add controller methods

  get '/figures' do

    erb :'/figures/index'

  end 

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  post '/figures' do

    @figure = Figure.create(params[:figure])
    create_new_landmark(@figure)
    create_new_title(@figure)
    redirect to '/figures'
  end

  get '/figures/:id/edit' do

    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do

    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    create_new_landmark(@figure) #helper method
    create_new_title(@figure) #helper method
    redirect to "/figures/#{@figure.id}" #double quotes when reidrecting w/ string interpolation 

  end 

    get '/figures/:id' do 

      @figure = Figure.find(params[:id])
      erb :'/figures/show'

  end

  private

  def create_new_landmark(figure)
    landmark = Landmark.new(params[:landmark])
    if landmark.name != ''
      figure.landmarks << landmark
    end
  end

  def create_new_title(figure)
    if params[:title][:name] != ''
      title = Title.create(params[:title])
      figure.titles << title
    end
  end
end
