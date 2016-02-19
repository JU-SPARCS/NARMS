# Controller for viewing the home page(base) for a User.
# Depending on the role of the user the content should be different.
Narms::App.controllers :base do

  get :index do
  	# TEST DATE
  	date = Date.today

  	# Retrieve the worker profile of the current user
    worker_profiles = WorkerProfile.where(user_id: current_user.id)

    # Get the current schedule for all the profiles
    worker_id = Array.new
	worker_profiles.each do |profile|
	  worker_id.push(profile.id)
	end
    @current_schedules = Schedules::Worker
      .where(:worker_profile_id => worker_id)
	  .where("begin < ?", date)
	  .where("end > ?", date)

    render '/base/list'
  end
end
