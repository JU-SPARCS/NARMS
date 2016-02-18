Narms::App.controllers :worker_schedules do

  # CURRENT: renders a view that displays a list of all existing Schedules:Worker.
  # HOW SHOULD BE: if the role of the current User is SHIFT_MANAGER or ATCO,
  # show a list of Schedules:Worker to which User's worker profiles are linked
  get :index do
    @worker_schedules = Schedules::Worker.all
    render '/worker_schedules/select_schedule'
  end

  # This method is called when a url of this form is used: /workers/:worker_id/schedules.
  # Renders a list of schedules for a WorkerProfile
   get :index, :parent => :workers do
     worker = WorkerProfile.find_by_id params[:worker_id]
     if worker
       @worker_schedules = worker.schedules
       render '/worker_schedules/select_schedule'
     else
       halt 404
     end
   end

 # This method is called when a url of this form is used: /workers/:worker_id/schedules/:id.
 # Renders a schedule
  get :index, :with => :id, :parent => :workers do
    schedule = Schedules::Worker.find_by_id params[:id]
    if schedule
      @schedule = schedule
      render '/worker_schedules/view'
    else
      halt 404
    end
  end


end
