require 'time'
Narms::App.controllers :log_events, :parent => [:workers] do

  get :index do
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

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end
  #
  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end
  #
  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end
  #
  # get '/example' do
  #   'Hello world!'
  # end


end
