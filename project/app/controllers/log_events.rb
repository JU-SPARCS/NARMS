require 'time'
Narms::App.controllers :log_events do

  get :index do
    # Here you should get the worker_profiles that are linked to the current_user.
    # However because at this point the link has not yet been created in the models, I will just query for all worker profiles.
    @worker_profiles = WorkerProfile.all
    render '/log_events/select_profile'
  end

  get :index, :parent => :workers do
    worker = WorkerProfile.find_by_id params[:worker_id]
    if worker
      if params[:start] && params[:end]
        start_date = DateTime.parse(params[:start])
        end_date = DateTime.parse(params[:end])
        log_events = Events::Log.where(:happened_at => start_date..end_date, :worker_profile => worker)
      else
        log_events = worker.log_events
      end
      @worker = worker
      @facility = @worker.facility
      @log_events = log_events
      render '/log_events/list'
    else
      halt 404
    end
  end
end
