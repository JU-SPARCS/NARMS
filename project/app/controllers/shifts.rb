Narms::App.controllers :shifts do

  get :index do
    @shifts = Shift.all
    render '/shifts/select_shift'
  end

  get :index, :with => :id do
    shift = Shift.find_by_id params[:id]
    if shift
      @shift = shift
      @workers = shift.worker_profiles
      render '/shifts/view'
    else
      halt 404
    end
  end


end
