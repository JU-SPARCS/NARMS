Narms::App.controllers :shifts do

  # CURRENT: renders a view that displays a list of all existing shifts.
  # HOW SHOULD BE: if the role of the current User is SHIFT_MANAGER or ATCO,
  # show a list of shifts to which User's worker profiles are linked
  get :index do
    @shifts = Shift.all
    @facilities = Facility.all
    @worker_profiles = WorkerProfile.all
    render '/shifts/select_shift'
  end

  post :index do
    beginDate = params[:begin_at]
    endDate = params[:end_at]
    facility = params[:facility]
    workers = WorkerProfile.where(pub_id: params[:workers])
    shift = Shift.create!(:begin => beginDate, :end => endDate,
                          :facility_id => facility)
    shift.worker_profiles << workers
    redirect :shifts
  end

  # Return a list of Shifts linked to the worker profile with id = :worker_profile
  get :index, :parent => :workers  do
    worker = WorkerProfile.find_by_id params[:worker_id]
    if worker
      @shifts = worker.shifts
      @facilities = Facility.all
      @worker_profiles = WorkerProfile.all
      render '/shifts/select_shift'
    else
      halt 404
    end
  end

  # Render information about a Shift with id = :id
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

  post :index, :with => :id do
    shift = Shift.find_by_id params[:id]
    if shift
      beginDate = DateTime.parse(params[:begin_at])
      workers = shift.worker_profiles.where(pub_id: params[:workers])

      beginWeekDate = beginDate.beginning_of_week.to_time
      endWeekDate = beginWeekDate + 6.days

      beginSlotDate = beginDate.to_time
      beginSlotDate.change({min: (beginDate.min / 30) * 30})
      endSlotDate = beginSlotDate + 30.minutes

      workers.each do |worker|
        schedule = worker.schedules.where(begin_at: beginWeekDate)

        if (schedule == nil || schedule.size == 0)
          schedule = Schedules::Worker.create!(:begin_at => beginWeekDate, :end_at => endWeekDate,
                                               :worker_profile => worker)
        else
          schedule = schedule.first
        end

        slot = schedule.slots.where(begin_at: beginSlotDate, schedules_worker_id: schedule.id)
        if (slot == nil || slot.size == 0)
          slot = ScheduleSlots::Worker.create!(:begin_at => beginSlotDate, :end_at => endSlotDate,
                                               :schedule => schedule)
        end
      end
      @shift = shift
      @workers = shift.worker_profiles
      render '/shifts/view'
    else
      halt 404
    end
  end

end
