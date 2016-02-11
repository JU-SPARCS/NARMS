Narms::App.controllers :worker_schedules do

  get :index do
    @worker_schedules = Schedules::Worker.all
    render '/worker_schedules/select_schedule'
  end

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
