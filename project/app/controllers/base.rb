# Controller for viewing the home page(base) for a User.
# Depending on the role of the user the content should be different.
Narms::App.controllers :base do

  get :index do
  	# Retrieve the worker profile of the current user
    @worker_profiles = WorkerProfile.where(user_id: current_user.id)
    render '/base/list'
  end

end
