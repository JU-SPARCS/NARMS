Narms::App.controllers :schedules do

  # This method is called when a url of this form is used: /schedules.
  # Renders a list of the worker_profiles for the user
  get :index do
    render '/schedules/schedules'
  end

  # This method is called when a url of this form is used: /worker_profiles/:wp_id/schedules.
  # Renders a list of schedules for a WorkerProfile
  get :index, :parent => :worker_profiles do
    @worker_profile = WorkerProfile.find_by_id params[:worker_profile_id]
    
    if current_user.is_authorized_to_perform_on_worker_profile("view_atco_worker_schedule", @worker_profile) then
      @start_at = if !params[:start_at].nil? then Date.parse(params[:start_at]).to_time else Date.today.beginning_of_week.to_time end
      @end_at = if !params[:end_at].nil? then Date.parse(params[:end_at]).to_time else @start_at.next_month end

      @shifts = Shift.from_worker_profile(@worker_profile).over_period(@start_at, @end_at)

      render '/schedules/schedules_worker_profile'
    else
      halt 403
    end
  end

  # This method is called when a url of this form is used: /worker_profiles/:wp_id/schedules/:sche_id.
  # Renders a schedule with the log events
  get :index, :with => :id, :parent => :worker_profiles do
    @schedule = Schedules::Worker.find_by_id params[:id]
    if current_user.is_authorized_to_perform_on_worker_profile("view_atco_worker_log_event", @schedule.worker_profile) then
      render '/schedules/detailed_schedule_worker_profile'
    else
      halt 403
    end
  end

end
