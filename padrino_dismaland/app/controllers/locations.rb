PadrinoDismaland::App.controllers :locations do
  before except: [:index, :root] do
    @location = Location.find(params[:id])
  end
  
#  set :views, layout: "application"
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  
  get :root, map: "/" do
    #@location = Location.find(19)
    #Info about all direction we can go from this location
    @locations_and_directions = Location.all.map do |loc| 
      { id: loc.id, name: loc.name,
	description: loc.description, 
        directions: loc.directions.map do |direction|
	{ direction: direction.get_direction_name,
   #The above could have been `direction: direction.direction`
	  destination_id: direction.destination_id }
	end,
	comments: loc.comments.order("created_at DESC").map do |comment|
	  { author: comment.author, 
	    body: comment.body, 
	    location_id: comment.location_id,
	    created_at: comment.created_at.strftime("%H:%M on %d %B %Y"), 
	    updated_at: comment.updated_at.strftime("%H:%M on %d %B %Y") }
	end
      }
     # @comments = Comment.order("created_at DESC")
    end
    render "/locations/index"
  end
  
  get :show, map: "/locations/:id" do
    render "/locations/show"
  end

  get :index do

  end

end
