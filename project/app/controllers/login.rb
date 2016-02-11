Narms::App.controllers :login do
  get :index do
    if current_user
      redirect url(:base,:index)
    else
      render "/login/login"
    end
  end

  post :index do
    user = User.authenticate(params[:email], params[:password])
    if user
      set_current_user user
      redirect url(:base, :index)
    else
      params[:email] = h(params[:email])
      flash.now[:error] = {'email': 'Invalid email and password combination.'}
      render '/login/login'
    end
  end

  delete :index do
    if current_user
      sign_out
      redirect url :login, :index
    end
  end
end
