Narms::App.controllers :login do

  # Renders the login page
  get :index do
    if current_user
      redirect url :base, :index
    else
      render "/login/login"
    end
  end

  # Method to which the login form submits
  post :index do
    email, password, token = params[:email], params[:password], params[:token]
    user = User.authenticate(email, password)
    worker_profile = WorkerProfile.find_by(user: nil, pub_id: token) if token

    if worker_profile || user
      if user && worker_profile
        user.worker_profiles << worker_profile if worker_profile

      elsif worker_profile
        first_name, name, = email.split(/\.|@/)
        role = Role.find_by_name('ATCO')
        user = User.create!(
          email: email,
          password: password,
          password_confirmation: password,
          first_name: first_name,
          name: name,
          role: role
        )
        user.worker_profiles << worker_profile
      end

      # if user :
      set_current_user user
      redirect url :base, :index

    else
      params[:email] = h(params[:email])
      flash.now[:error] = {'email': 'Invalid email and password combination.'}
      render '/login/login'
    end
  end

  # Method that executes logout
  delete :index do
    if current_user
      sign_out
      redirect url :login, :index
    end
  end
end
