Narms::App.controllers :worker_profiles do

  # This method is called when a url of this form is used: /worker_profiles.
  # Renders a list of the worker_profiles for the user
  get :index do
    # Get all worker profiles
    @worker_profiles = WorkerProfile.where(user_id: current_user.id).order(:name)
    # Get worker profile with incoming work
    @worker_profiles_up = Array.new
    now = Time.now
    @worker_profiles.each do |worker_profile|
      worker_profile.schedules.each do |schedule|
        # If the end any schedule has not passed yet, save the worker profile
        if now < schedule.end
          @worker_profiles_up.push(worker_profile)
          break
        end
      end
    end

    render '/worker_profiles/worker_profiles'
  end


end
