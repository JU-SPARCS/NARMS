Narms::App.controllers :base do

  get :index do
    @worker_profiles = WorkerProfile.all

    render '/base/list'
  end

end
