Narms::App.controllers :login do
  get :index do
    "TODO: login page..."
    # render 'index'
  end

  post :index do
    set_current_user User.authenticate(params[:email], params[:password])
    redirect nil
  end

  delete :index do
    sign_out
    redirect url(:login, :index)
  end
end
