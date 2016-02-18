# Controller for viewing the home page(base) for a User.
# Depending on the role of the user the content should be different.
Narms::App.controllers :base do

  # CURRENT: Because at the moment User is not linked to WorkerProfile, the method sends
  # ALL existing worker_profiles to the view.
  #
  # HOW IT SHOULD BE: The method should return a page where the worker profiles of the current user are show,
  # if he has role of SHIFT_MANAGER or ATCO
  get :index do
    @worker_profiles = WorkerProfile.all
    render '/base/list'
  end

end
