Narms::App.controllers :log_events do

  # Renders the log_events page
  get :index do
    @current_user = current_user
    render '/log_events/log_events'
  end

end
