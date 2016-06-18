PadrinoDismaland::App.controllers :comments do

  before except: :create do
    @comment = Comment.find(params[:id])
  end
  
  post :create, map: "/comments" do
    comment = Comment.create(params[:comment])
    response.headers["Content-type"] = "application/json"
    comment.to_json
  end

  put :update, map: "/comments/:id" do
    @comment.update(params[:comment])
    response.headers["Content-type"] = "application/json"
    @comment.to_json
  end

  delete :destroy, map: "/comments/:id" do
    @comment.destroy
    response.headers["Content-type"] = "application/json"
    @comment.to_json #Remind the browser of which comment was deleted.
  end

end
