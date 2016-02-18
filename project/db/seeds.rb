# Seeding file to use to fill the database with starting data

# Add transaction to rollback the seed if any error occurs
ActiveRecord::Base.transaction do
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
    # Create roles
    role_sm = Role.create!(name: 'SHIFT_MANAGER')
    role_acto = Role.create!(name: 'ATCO')

    # Create users - 1 Shift Manager and 5 ATCO
    sm = role_sm.users.create!(first_name: 'Tim', name: 'Crowford', email: 'tcrowford@gmail.com', password:'tcrowford', password_confirmation:'tcrowford')
    atco1 = role_acto.users.create(first_name: 'John', name: 'Deuf', email: 'jdeuf@gmail.com', password:'jdeuf', password_confirmation:'jdeuf')
    atco2 = role_acto.users.create(first_name: 'Marie', name: 'Rouana', email: 'mrouana@gmail.com', password:'mrouana', password_confirmation:'mrouana')
    atco3 = role_acto.users.create(first_name: 'Milene', name: 'Micoton', email: 'mmicoton@gmail.com', password:'mmicoton', password_confirmation:'mmicoton')
    atco4 = role_acto.users.create(first_name: 'Anna', name: 'Conda', email: 'aconda@gmail.com', password:'aconda', password_confirmation:'aconda')
    atco5 = role_acto.users.create(first_name: 'Aude', name: 'Javel', email: 'ajaval@gmail.com', password:'ajaval', password_confirmation:'ajaval')

    # Create 2 facilities
    f1 = Facility.create!(name: 'Nordica 2', pub_id: '123')
    f2 = Facility.create!(name: 'Jonkoping NextJet', pub_id: '321')

    # Create workstations on these facilities
    ws1 = f1.workstations.create!(name: "WK 1")
    ws2 = f1.workstations.create!(name: "WK 2")
    ws3 = f2.workstations.create!(name: "SW 1 - NJ")

    # Create ATCO's worker profiles - one ATCO has several worker profiles on different facilities
    wo1 = atco1.worker_profiles.create!(first_name: atco1.first_name, name: atco1.name, facility_id: f1.id, pub_id: '2101')
    wo2 = atco2.worker_profiles.create!(first_name: atco2.first_name, name: atco2.name, facility_id: f1.id, pub_id: '2102')
    wo3 = atco3.worker_profiles.create!(first_name: atco3.first_name, name: atco3.name, facility_id: f1.id,  pub_id: '2103')
    wo4 = atco4.worker_profiles.create!(first_name: atco4.first_name, name: atco4.name, facility_id: f1.id, pub_id: '2104')
    wo5 = atco5.worker_profiles.create!(first_name: atco5.first_name, name: atco4.name, facility_id: f1.id, pub_id: '2105')
    wo6 = atco1.worker_profiles.create!(first_name: atco1.first_name, name: atco1.name, facility_id: f2.id, pub_id: '2243')
    
    # Create shifts over several period on several facilities.
    sft1 = f1.shifts.create!(begin: DateTime.parse('2015-02-11 00:00:00'), end: DateTime.parse('2017-03-11 00:00:00'))
    sft2 = f1.shifts.create!(begin: DateTime.parse('2015-03-11 00:00:00'), end: DateTime.parse('2017-04-11 00:00:00'))
    sft3 = f2.shifts.create!(begin: DateTime.parse('2015-02-11 00:00:00'), end: DateTime.parse('2017-03-11 00:00:00'))

    # Assign worker profile to shifts. The worker profile must be assign on shift in their facility
    # WARNING: No worker profile can be on shifts with overlapping period.
    sft1.worker_profiles << [wo1, wo2, wo3]
    sft2.worker_profiles << [wo1, wo4, wo5]
    sft3.worker_profiles << [wo6]

    # Create a schedule for a worker profile
    sch1 = wo1.schedules.create!(begin: '2016-02-11 10:00:00', end: '2015-02-18 10:00:00')
    # Create slots for this schedule
    slt1 = sch1.slots.create!(begin: '2016-02-11 10:30:00', end: '2016-02-1 11:00:00')
    slt2 = sch1.slots.create!(begin: '2016-02-11 17:00:00', end: '2016-02-11 17:30:00')
    slt3 = sch1.slots.create!(begin: '2016-02-12 13:30:00', end: '2016-02-12 14:00:00')
    slt4 = sch1.slots.create!(begin: '2016-02-12 14:00:00', end: '2016-02-12 15:00:00')

    # Create second schedule for another worker profile of the same user
    sch2 = wo6.schedules.create!(begin: '2016-02-11 10:00:00', end: '2015-02-18 10:00:00' )
    # Create slots for this schedule
    slt5 = sch2.slots.create!(begin: '2016-02-11 11:30:00', end: '2016-02-10 12:00:00')
    slt6 = sch2.slots.create!(begin: '2016-02-11 12:00:00', end: '2016-02-10 12:30:00')
    slt7 = sch2.slots.create!(begin: '2016-02-13 07:30:00', end: '2016-02-13 08:00:00')

    # Add lof events to be mapped to the created schedules
    wo1.log_events.create!(workstation_id: ws1.id, happened_at: '2016-02-11 10:30:00', worker_role: 'PROCEDURAL ENROUTE', worker_responsability: 'DEPARTURE', operational_status: 'MRC')
    wo1.log_events.create!(workstation_id: ws1.id, happened_at: '2016-02-11 11:00:00', worker_role: 'PROCEDURAL ENROUTE', worker_responsability: 'PLANNING', operational_status: 'SC')
    wo1.log_events.create!(workstation_id: ws2.id, happened_at: '2016-02-12 13:00:00', worker_role: 'PROCEDURAL ENROUTE', worker_responsability: 'PLANNING', operational_status: 'SC')
    wo1.log_events.create!(workstation_id: ws2.id, happened_at: '2016-02-12 15:00:00', worker_role: 'PROCEDURAL ENROUTE', worker_responsability: 'PLANNING', operational_status: 'SC')

  end
end