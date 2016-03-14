# Seeding file to use to fill the database with starting data

# Add transaction to rollback the seed if any error occurs
ActiveRecord::Base.transaction do

  # Launch with deseed=true as argument to deseed the database
  if ENV["deseed"]
    Role.delete_all
    User.delete_all
    Facility.delete_all
    Workstation.delete_all
    WorkerProfile.delete_all
    Shift.delete_all
    Schedules::Worker.delete_all
    ScheduleSlots::Worker.delete_all
    Events::Log.delete_all
  else
    # Create roles and permissions
    permission_sm = PermissionsTables::ShiftManagement.create(
        conduct_safaps_assessment: :shift,
        prepare_shift_schedule: :shift,
        view_atco_safaps_shift_inputs: :shift,
        view_atco_safaps_shift_assessments: :shift,
        view_atco_worker_schedule: :shift,
        view_atco_worker_log_event: :shift
    )
    role_sm = Role.create!(name: 'SHIFT_MANAGER', shift_management_permissions_table: permission_sm)
    permission_atco = PermissionsTables::ShiftManagement.create(
        conduct_safaps_assessment: :nobody,
        prepare_shift_schedule: :nobody,
        view_atco_safaps_shift_inputs: :nobody,
        view_atco_safaps_shift_assessments: :self,
        view_atco_worker_schedule: :self,
        view_atco_worker_log_event: :self
    )
    role_acto = Role.create!(name: 'ATCO', shift_management_permissions_table: permission_atco)

    # Create users - 1 Shift Manager and 5 ATCO
    sm1 = role_sm.users.create!(first_name: 'Jean', name: 'Neimard', email: 'jneimard@gmail.com', password:'jneimard', password_confirmation:'jneimard')
    sm2 = role_sm.users.create!(first_name: 'Tim', name: 'Crowford', email: 'tcrowford@gmail.com', password:'tcrowford', password_confirmation:'tcrowford')
    atco1 = role_acto.users.create(first_name: 'John', name: 'Deuf', email: 'jdeuf@gmail.com', password:'jdeuf', password_confirmation:'jdeuf')
    atco2 = role_acto.users.create(first_name: 'Marie', name: 'Rouana', email: 'mrouana@gmail.com', password:'mrouana', password_confirmation:'mrouana')
    atco3 = role_acto.users.create(first_name: 'Milene', name: 'Micoton', email: 'mmicoton@gmail.com', password:'mmicoton', password_confirmation:'mmicoton')
    atco4 = role_acto.users.create(first_name: 'Anna', name: 'Conda', email: 'aconda@gmail.com', password:'aconda', password_confirmation:'aconda')
    atco5 = role_acto.users.create(first_name: 'Aude', name: 'Javel', email: 'ajavel@gmail.com', password:'ajavel', password_confirmation:'ajavel')

    # Create 2 facilities
    f1 = Facility.create!(name: 'Nordica 2', pub_id: '123')
    f2 = Facility.create!(name: 'Jonkoping NextJet', pub_id: '321')

    # Create workstations on these facilities
    ws1 = f1.workstations.create!(name: "WK 1")
    ws2 = f1.workstations.create!(name: "WK 2")
    ws3 = f2.workstations.create!(name: "SW 1 - NJ")

    # Create ATCO's worker profiles - one ATCO has several worker profiles on different facilities
    wosm1_1 = sm1.worker_profiles.create!(first_name: sm1.first_name, name: sm1.name, facility_id: f1.id, pub_id: '2001')
    wosm1_2 = sm1.worker_profiles.create!(first_name: sm1.first_name, name: sm1.name, facility_id: f2.id, pub_id: '2141')
    wosm2 = sm2.worker_profiles.create!(first_name: sm2.first_name, name: sm2.name, facility_id: f1.id, pub_id: '2002')
    wo1_1 = atco1.worker_profiles.create!(first_name: atco1.first_name, name: atco1.name, facility_id: f1.id, pub_id: '2101')
    wo1_2 = atco1.worker_profiles.create!(first_name: atco1.first_name, name: atco1.name, facility_id: f2.id, pub_id: '2241')
    wo2 = atco2.worker_profiles.create!(first_name: atco2.first_name, name: atco2.name, facility_id: f1.id, pub_id: '2102')
    wo3 = atco3.worker_profiles.create!(first_name: atco3.first_name, name: atco3.name, facility_id: f1.id, pub_id: '2103')
    wo4 = atco4.worker_profiles.create!(first_name: atco4.first_name, name: atco4.name, facility_id: f1.id, pub_id: '2104')
    wo5 = atco5.worker_profiles.create!(first_name: atco5.first_name, name: atco5.name, facility_id: f1.id, pub_id: '2105')
    
    today = Date.today.to_time
    beginning_of_week = today.beginning_of_week
    # Create shifts over several period on several facilities.
    sft1 = f1.shifts.create!(begin: beginning_of_week, end: beginning_of_week.next_month)
    sft2 = f1.shifts.create!(begin: beginning_of_week.next_month, end: beginning_of_week.next_month.next_month)
    sft3 = f2.shifts.create!(begin: beginning_of_week, end: beginning_of_week.next_month)

    # Assign worker profile to shifts. The worker profile must be assign on shift in their facility
    # WARNING: No worker profile can be on shifts with overlapping period.
    sft1.worker_profiles << [wosm1_1, wo1_1, wo2, wo3]
    sft2.worker_profiles << [wosm2, wo1_1, wo4, wo5]
    sft3.worker_profiles << [wosm1_2, wo1_2]

    # Create a schedule for a worker profile
    s1_1 = wosm2.schedules.create!(begin_at: today.beginning_of_week, end_at: today.end_of_week)
    # Create slots for this schedule
    slt1 = s1_1.slots.create!(begin_at: beginning_of_week.change(:hour => 10, :min => 30, :sec => 0), end_at: beginning_of_week.change(:hour => 11, :min => 0, :sec => 0))
    slt12 = s1_1.slots.create!(begin_at: beginning_of_week.change(:hour => 10, :min => 30, :sec => 0), end_at: beginning_of_week.change(:hour => 11, :min => 0, :sec => 0))
    slt2 = s1_1.slots.create!(begin_at: beginning_of_week.change(:hour => 17, :min => 00, :sec => 0), end_at: beginning_of_week.change(:hour => 17, :min => 30, :sec => 0))
    slt3 = s1_1.slots.create!(begin_at: beginning_of_week.tomorrow.change(:hour => 13, :min => 30, :sec => 0), end_at: beginning_of_week.tomorrow.change(:hour => 14, :min => 0, :sec => 0))
    slt4 = s1_1.slots.create!(begin_at: beginning_of_week.tomorrow.change(:hour => 14, :min => 00, :sec => 0), end_at: beginning_of_week.tomorrow.change(:hour => 14, :min => 30, :sec => 0))

    # Create a schedule for a worker profile
    sch1_1 = wo1_1.schedules.create!(begin_at: today.beginning_of_week, end_at: today.end_of_week)
    # Create slots for this schedule
    slt1 = sch1_1.slots.create!(begin_at: beginning_of_week.change(:hour => 10, :min => 30, :sec => 0), end_at: beginning_of_week.change(:hour => 11, :min => 0, :sec => 0))
    slt12 = sch1_1.slots.create!(begin_at: beginning_of_week.change(:hour => 10, :min => 30, :sec => 0), end_at: beginning_of_week.change(:hour => 11, :min => 0, :sec => 0))
    slt2 = sch1_1.slots.create!(begin_at: beginning_of_week.change(:hour => 17, :min => 00, :sec => 0), end_at: beginning_of_week.change(:hour => 17, :min => 30, :sec => 0))
    slt3 = sch1_1.slots.create!(begin_at: beginning_of_week.tomorrow.change(:hour => 13, :min => 30, :sec => 0), end_at: beginning_of_week.tomorrow.change(:hour => 14, :min => 0, :sec => 0))
    slt4 = sch1_1.slots.create!(begin_at: beginning_of_week.tomorrow.change(:hour => 14, :min => 00, :sec => 0), end_at: beginning_of_week.tomorrow.change(:hour => 14, :min => 30, :sec => 0))

    # Create a schedule for a worker profile
    sch1_2 = wo1_1.schedules.create!(begin_at: today.next_week.beginning_of_week, end_at: today.next_week.end_of_week)
    # Create slots for this schedule
    slt5 = sch1_2.slots.create!(begin_at: today.next_week.beginning_of_week.change(:hour => 10, :min => 30, :sec => 0), end_at: today.next_week.beginning_of_week.change(:hour => 11, :min => 0, :sec => 0))
    slt13 = sch1_2.slots.create!(begin_at: today.next_week.beginning_of_week.change(:hour => 10, :min => 30, :sec => 0), end_at: today.next_week.beginning_of_week.change(:hour => 11, :min => 0, :sec => 0))
    slt6 = sch1_2.slots.create!(begin_at: today.next_week.beginning_of_week.change(:hour => 17, :min => 00, :sec => 0), end_at: today.next_week.beginning_of_week.change(:hour => 17, :min => 30, :sec => 0))
    slt7 = sch1_2.slots.create!(begin_at: today.next_week.beginning_of_week.tomorrow.change(:hour => 13, :min => 30, :sec => 0), end_at: today.next_week.beginning_of_week.tomorrow.change(:hour => 14, :min => 0, :sec => 0))
    slt8 = sch1_2.slots.create!(begin_at: today.next_week.beginning_of_week.tomorrow.change(:hour => 14, :min => 00, :sec => 0), end_at: today.next_week.beginning_of_week.tomorrow.change(:hour => 14, :min => 30, :sec => 0))

    # Create second schedule for another worker profile of the same user
    sch2 = wo1_2.schedules.create!(begin_at: today.beginning_of_week, end_at: today.end_of_week)
    # Create slots for this schedule
    slt9 = sch2.slots.create!(begin_at: beginning_of_week.change(:hour => 14, :min => 30, :sec => 0), end_at: beginning_of_week.change(:hour => 15, :min => 0, :sec => 0))
    slt10 = sch2.slots.create!(begin_at: beginning_of_week.change(:hour => 15, :min => 0, :sec => 0), end_at: beginning_of_week.change(:hour => 15, :min => 30, :sec => 0))
    slt11 = sch2.slots.create!(begin_at: beginning_of_week.tomorrow.tomorrow.change(:hour => 8, :min => 30, :sec => 0), end_at: beginning_of_week.change(:hour => 9, :min => 0, :sec => 0))

    # Add lof events to be mapped to the created schedules
    wo1_1.log_events.create!(workstation_id: ws1.id, happened_at: '2016-02-11 10:30:00', worker_role: 'PROCEDURAL ENROUTE', worker_responsability: 'DEPARTURE', operational_status: 'MRC')
    wo1_1.log_events.create!(workstation_id: ws1.id, happened_at: '2016-02-11 11:00:00', worker_role: 'PROCEDURAL ENROUTE', worker_responsability: 'PLANNING', operational_status: 'SC')
    wo1_1.log_events.create!(workstation_id: ws2.id, happened_at: '2016-02-12 13:00:00', worker_role: 'PROCEDURAL ENROUTE', worker_responsability: 'PLANNING', operational_status: 'SC')
    wo1_1.log_events.create!(workstation_id: ws2.id, happened_at: '2016-02-12 15:00:00', worker_role: 'PROCEDURAL ENROUTE', worker_responsability: 'PLANNING', operational_status: 'SC')

  end
end