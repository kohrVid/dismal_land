PadrinoDismaland::App.controllers :comments do
  before except: :create do
    comment = Comment.find(params[:comment][:id])
  end
  
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
  
  post :create, map: "/comments" do
    comment = Comment.create(params[:comment])
    comment.to_json
  end

  put :update do
    comment.update(params[:comment])
    comment.to_json
  end

  delete :destroy do
    comment.destroy
    Comment.all.to_json
  end

end
