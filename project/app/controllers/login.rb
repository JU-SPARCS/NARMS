Narms::App.controllers :login do
  get :index do
    "TODO: login page..."
    render :login
  end

  post :index do
    user = User.authenticate(params[:email], params[:password])
    set_current_user = user
    if user != nil then
      render 'Logged in'
    else
      redirect :login
    end
  end

  delete :index do
    sign_out
    redirect url(:login, :index)
  end
end
