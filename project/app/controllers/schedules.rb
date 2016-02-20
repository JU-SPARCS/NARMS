Narms::App.controllers :schedules do

  # This method is called when a url of this form is used: /schedules.
  # Renders a list of the worker_profiles for the user
  get :index do
    render '/schedules/schedules'
  end

  # This method is called when a url of this form is used: /worker_profiles/:wp_id/schedules.
  # Renders a list of schedules for a WorkerProfile
  get :index, :parent => :worker_profiles do
    @start_at = if !params[:start_at].nil? then Date.parse(params[:start_at]).to_time else Date.today.beginning_of_week.to_time end
    @end_at = if !params[:end_at].nil? then Date.parse(params[:end_at]).to_time else @start_at.next_month end

    @worker_profile = WorkerProfile.find_by_id params[:worker_profile_id]
    @shifts = Shift.joins("join shifts_worker_profiles on shifts.id = shifts_worker_profiles.shift_id")
      .where("shifts_worker_profiles.worker_profile_id = ?", @worker_profile.id)
      .where("end > ?", @start_at)
      .where("begin < ?", @end_at)

    # @schedules = Schedules::Worker
    #   .where(:worker_profile_id => @worker_profile.id)
    #   .where("end > ?", @start_at)
    #   .where("begin < ?", @end_at)
    #   .order(:begin)

    render '/schedules/schedules_worker_profile'
  end

  # # This method is called when a url of this form is used: /worker_profiles/:wp_id/schedules/:sche_id.
  # # Renders a schedule with the log events
  # get :index, :with => :id, :parent => :worker_schedules do
  #   @schedule = Schedules::Worker.find_by_id params[:id]
  #   # TODO get the slots from schedule.begin < slot.created_at < schedule.end for this worker_profile
  #   if @schedule
  #     render '/worker_schedules/detail_schedule'
  #   else
  #     halt 404
  #   end
  # end

end
