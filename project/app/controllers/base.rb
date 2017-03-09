# Controller for viewing the home page(base) for a User.
# Depending on the role of the user the content should be different.
Narms::App.controllers :base, map: '/' do

  get :index do
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
      .where("begin_at <= ?", date)
      .where("end_at >= ?", date)

    render '/base/home'
  end
end
