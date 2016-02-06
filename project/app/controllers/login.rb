Narms::App.controllers :login do
  get :index do
    "TODO: login page..."
    render :login
  end

  post :index do
    user = User.authenticate(params[:email], params[:password])
    if user
      set_current_user = user
      'Logged in'
    else
      params[:email] = h(params[:email])
      flash.now[:error] = {'email': 'Invalid email and password combination.'}
      render "/login/login"
    end
  end

  delete :index do
    sign_out
    redirect url(:login, :index)
  end
end
