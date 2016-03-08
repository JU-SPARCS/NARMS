Narms::App.controllers :shifts do

  # CURRENT: renders a view that displays a list of all existing shifts.
  # HOW SHOULD BE: if the role of the current User is SHIFT_MANAGER or ATCO,
  # show a list of shifts to which User's worker profiles are linked
  get :index do
    puts "hellooooooo"
    @shifts = Shift.all
    render '/shifts/select_shift'
  end

  # Return a list of Shifts linked to the worker profile with id = :worker_profile
  get :index, :parent => :workers  do
    puts "helloooooo2"
    worker = WorkerProfile.find_by_id params[:worker_id]
    if worker
      @shifts = worker.shifts
      render '/shifts/select_shift'
    else
      halt 404
    end
  end

  # Render information about a Shift with id = :id
  get :index, :with => :id do
    puts "hellooooooo3"
    shift = Shift.find_by_id params[:id]
    if shift
      @shift = shift
      @workers = shift.worker_profiles
      render '/shifts/view'
    else
      halt 404
    end
  end

  def sendTo

    puts "oyuyouyouyouyoyuuy - - - - - - - - "
  end

end
