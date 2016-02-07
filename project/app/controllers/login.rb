Narms::App.controllers :login do
  get :index do
    "TODO: redirect if logged in already."
    if current_user
      render "/worker/profile"
    else
      render "/login/login"
    end
  end

  post :index do
    user = User.authenticate(params[:email], params[:password])
    if user
      set_current_user = user
      "TODO: redirect instead of just rendering."
      render "/worker/profile"
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
