Narms::App.controllers :schedules do

  # This method is called when a url of this form is used: /schedules.
  # Renders a list of the worker_profiles for the user
  get :index do
    puts "here ... "
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
    date = Date.today
    # Retrieve the worker profile of the current user
    worker_profiles = WorkerProfile.where(user_id: current_user.id)

    # Get the current schedule for all the profiles
    worker_id = Array.new
    worker_profiles.each do |profile|
      worker_id.push(profile.id)
    end
    puts worker_id
    @current_schedules = Schedules::Worker
      .where(:worker_profile_id => worker_id)
      .where("begin_at < ?", date)
      .where("end_at > ?", date)
    if current_user.is_authorized_to_perform_on_worker_profile("view_atco_worker_log_event", @schedule.worker_profile) then
      render '/schedules/detailed_schedule_worker_profile'
    else
      halt 403
    end
  end
  

  get :index, :with => :id do
    puts "hellooooooo121221212 :DDDDDDDD"
    
  end

  post :send do
    puts 'zizizizizizi +++++++ '
    redirect 'worker_profiles/3/schedules/1'
    token = 'NEtKcVJ4VUtRUXd1S1BiTQ=='
    url = ''
    events = { "ResponseURL": "http://toto.fr",
                  "Events": [
                    {
                      "TimeZone": "Europe/Paris",
                      "StartTime": "2016-02-05 17:18:30",
                      "EndTime": "2016-02-06 17:18:30",
                      "ASMEnvironment": "T",
                      "ControlTechnology": "R",
                      "ControllerStatus": "MCS",
                      "Traffic": "VL",
                      "Equipment": "O",
                      "Weather": "HD"
                    },
                    {
                      "TimeZone": "Europe/Paris",
                      "StartTime": "2016-02-05 17:18:30",
                      "EndTime": "2016-02-06 17:18:30",
                      "ASMEnvironment": "T",
                      "ControlTechnology": "R",
                      "ControllerStatus": "MCS",
                      "Traffic": "H",
                      "Equipment": "O",
                      "Weather": "HD"
                    }
                  ]
                }#Events.where(id: params[:event_ids])
 
    Typhoeus.post(
      "193.10.30.123/evaluations",
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => token,
      },
      body: {
        'ResponseURL' => url,
        'Events' => events,
      }.to_json
    )
  end

  def sendTo
    puts "oyuyouyouyouyoyuuy - - - - - - - - "
  end

end
