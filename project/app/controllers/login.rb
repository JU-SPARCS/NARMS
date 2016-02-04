Narms::App.controllers :login do
  get :index do
    "TODO: login page..."
    render :login
  end

  post :index do
    user = User.authenticate(params[:email], params[:password])
    puts user
    if user
      set_current_user = user
      'Logged in'
    else
      redirect :login
    end

    # if params[:email] == "atco@gmail.com" and params[:password] == "password" then
    #   'Logged in'
    # else
    #   redirect :login
    # end
  end

  delete :index do
    sign_out
    redirect url(:login, :index)
  end
end
