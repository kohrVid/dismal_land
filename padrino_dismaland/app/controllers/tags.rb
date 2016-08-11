PadrinoDismaland::App.controllers :tags do
  before except: [:index, :new, :create] do
    @tag = Tag.find(params[:id])
  end
  
  get :index, map: "/tags" do
    @tags_and_locations = Tag.all.map do |tag| 
      { 
	id: tag.id, name: tag.name,
        locations: tag.locations.map do |location|
	  { name: location.name, id: location.id }
	end,
        location_tags: tag.location_tags.map do |location_tag|
	  { 
	    location_id: location_tag.location_id,
	    tag_id: location_tag.tag_id
	  }
	end
      }
    end
    @tags = Tag.all
    render "/tags/index"
  end

  get :new, map: "/tags/new" do
    @tag = Tag.new
    render "/tags/new"
  end

  get :edit, map: "/tags/:id/edit" do
    render "/tags/edit"
  end

  get :show, map: "/tags/:id" do
    render "/tags/show"
  end

  post :create, map: "/tags" do
    tag = Tag.create(params[:tag][:name])
    tag.locations << Location.find(params[:location_id])
    response.headers["Content-type"] = "application/json"
    tag.to_json
  end

  put :update, map: "/tags/:id" do
    @tag.update(params[:tag])
    @tag.locations << Location.find(params[:location])
    redirect "/tags/#{@tag.id}"
  end

  delete :destroy do
    @tag.destroy
    redirect "/tags"
  end

end
