Narms::App.controllers :login do
  get :index do
    if current_user
      redirect nil
    else
      render "/login/login"
    end
  end

  post :index do
    user = User.authenticate(params[:email], params[:password])
    if user
      set_current_user user
      redirect nil
    else
      params[:email] = h(params[:email])
      flash.now[:error] = {'email': 'Invalid email and password combination.'}
      redirect url :login, :login
    end
  end

  delete :index do
    if current_user
      sign_out
      redirect url :login, :index
    end
  end
end
