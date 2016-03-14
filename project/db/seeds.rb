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

    # Creating recipient 1

    ThirdParties::Recipient.create!(name: 'SAMO') do |samo|

      # Creating organization 1

      samo.organizations.new(name: 'Aeroports de Paris') do |adp|
        adp.token_holders.new(name: 'CDG')
        adp.token_holders.new(name: 'ORY')
        adp.token_holders.new(name: 'BVA')
      end

      # Creating organization 2

      f1 = Facility.create!(name: 'Nordica 2') do |f|

        # Creating workstations

        f.workstations.new(name: 'N2-A-1')
        f.workstations.new(name: 'N2-A-2')
        f.workstations.new(name: 'N2-B-1')

        # Creating worker profiles
        f.worker_profiles.new()    
      end

      f2 = Facility.create!(name: 'Jonkoping NextJet') do |f|
        f.workstations.new(name: 'JNJ-A-1')
        f.workstations.new(name: 'JNJ-A-2')
        f.workstations.new(name: 'JNJ-B-1')
      end

      samo.organizations.new(name: 'Jonkoping airports') do |ja|
        ja.token_holders.new(tokenable_r: f1, name: 'Nordica 2')
        ja.token_holders.new(tokenable_r: f2, name: 'Jonkoping NextJet')
      end
    end
    

    # # Create 2 facilities
    # f1 = Facility.create!(name: 'Nordica 2', pub_id: '123')
    # f2 = Facility.create!(name: 'Jonkoping NextJet', pub_id: '321')

    # # Create workstations on these facilities
    # ws1 = f1.workstations.create!(name: "WK 1")
    # ws2 = f1.workstations.create!(name: "WK 2")
    # ws3 = f2.workstations.create!(name: "SW 1 - NJ")

    # # Create ATCO's worker profiles - one ATCO has several worker profiles on different facilities
    # wosm1_1 = sm1.worker_profiles.create!(first_name: sm1.first_name, name: sm1.name, facility_id: f1.id, pub_id: '2001')
    # wosm1_2 = sm1.worker_profiles.create!(first_name: sm1.first_name, name: sm1.name, facility_id: f2.id, pub_id: '2141')
    # wosm2 = sm2.worker_profiles.create!(first_name: sm2.first_name, name: sm2.name, facility_id: f1.id, pub_id: '2002')
    # wo1_1 = atco1.worker_profiles.create!(first_name: atco1.first_name, name: atco1.name, facility_id: f1.id, pub_id: '2101')
    # wo1_2 = atco1.worker_profiles.create!(first_name: atco1.first_name, name: atco1.name, facility_id: f2.id, pub_id: '2241')
    # today = Date.today.to_time
    # beginning_of_week = today.beginning_of_week
    # # Create shifts over several period on several facilities.
    # sft1 = f1.shifts.create!(begin: beginning_of_week, end: beginning_of_week.next_month)
    # sft2 = f1.shifts.create!(begin: beginning_of_week.next_month, end: beginning_of_week.next_month.next_month)
    # sft3 = f2.shifts.create!(begin: beginning_of_week, end: beginning_of_week.next_month)

    # # Assign worker profile to shifts. The worker profile must be assign on shift in their facility
    # # WARNING: No worker profile can be on shifts with overlapping period.
    # sft1.worker_profiles << [wosm1_1, wo1_1, wo2, wo3]
    # sft2.worker_profiles << [wosm2, wo1_1, wo4, wo5]
    # sft3.worker_profiles << [wosm1_2, wo1_2]

    # # Create a schedule for a worker profile
    # s1_1 = wosm2.schedules.create!(begin: today.beginning_of_week, end: today.end_of_week)
    # # Create slots for this schedule
    # slt1 = s1_1.slots.create!(begin: beginning_of_week.change(:hour => 10, :min => 30, :sec => 0), end: beginning_of_week.change(:hour => 11, :min => 0, :sec => 0))
    # slt12 = s1_1.slots.create!(begin: beginning_of_week.change(:hour => 10, :min => 30, :sec => 0), end: beginning_of_week.change(:hour => 11, :min => 0, :sec => 0))
    # slt2 = s1_1.slots.create!(begin: beginning_of_week.change(:hour => 17, :min => 00, :sec => 0), end: beginning_of_week.change(:hour => 17, :min => 30, :sec => 0))
    # slt3 = s1_1.slots.create!(begin: beginning_of_week.tomorrow.change(:hour => 13, :min => 30, :sec => 0), end: beginning_of_week.tomorrow.change(:hour => 14, :min => 0, :sec => 0))
    # slt4 = s1_1.slots.create!(begin: beginning_of_week.tomorrow.change(:hour => 14, :min => 00, :sec => 0), end: beginning_of_week.tomorrow.change(:hour => 14, :min => 30, :sec => 0))

    # # Create a schedule for a worker profile
    # sch1_1 = wo1_1.schedules.create!(begin: today.beginning_of_week, end: today.end_of_week)
    # # Create slots for this schedule
    # slt1 = sch1_1.slots.create!(begin: beginning_of_week.change(:hour => 10, :min => 30, :sec => 0), end: beginning_of_week.change(:hour => 11, :min => 0, :sec => 0))
    # slt12 = sch1_1.slots.create!(begin: beginning_of_week.change(:hour => 10, :min => 30, :sec => 0), end: beginning_of_week.change(:hour => 11, :min => 0, :sec => 0))
    # slt2 = sch1_1.slots.create!(begin: beginning_of_week.change(:hour => 17, :min => 00, :sec => 0), end: beginning_of_week.change(:hour => 17, :min => 30, :sec => 0))
    # slt3 = sch1_1.slots.create!(begin: beginning_of_week.tomorrow.change(:hour => 13, :min => 30, :sec => 0), end: beginning_of_week.tomorrow.change(:hour => 14, :min => 0, :sec => 0))
    # slt4 = sch1_1.slots.create!(begin: beginning_of_week.tomorrow.change(:hour => 14, :min => 00, :sec => 0), end: beginning_of_week.tomorrow.change(:hour => 14, :min => 30, :sec => 0))

    # # Create a schedule for a worker profile
    # sch1_2 = wo1_1.schedules.create!(begin: today.next_week.beginning_of_week, end: today.next_week.end_of_week)
    # # Create slots for this schedule
    # slt5 = sch1_2.slots.create!(begin: today.next_week.beginning_of_week.change(:hour => 10, :min => 30, :sec => 0), end: today.next_week.beginning_of_week.change(:hour => 11, :min => 0, :sec => 0))
    # slt13 = sch1_2.slots.create!(begin: today.next_week.beginning_of_week.change(:hour => 10, :min => 30, :sec => 0), end: today.next_week.beginning_of_week.change(:hour => 11, :min => 0, :sec => 0))
    # slt6 = sch1_2.slots.create!(begin: today.next_week.beginning_of_week.change(:hour => 17, :min => 00, :sec => 0), end: today.next_week.beginning_of_week.change(:hour => 17, :min => 30, :sec => 0))
    # slt7 = sch1_2.slots.create!(begin: today.next_week.beginning_of_week.tomorrow.change(:hour => 13, :min => 30, :sec => 0), end: today.next_week.beginning_of_week.tomorrow.change(:hour => 14, :min => 0, :sec => 0))
    # slt8 = sch1_2.slots.create!(begin: today.next_week.beginning_of_week.tomorrow.change(:hour => 14, :min => 00, :sec => 0), end: today.next_week.beginning_of_week.tomorrow.change(:hour => 14, :min => 30, :sec => 0))

    # # Create second schedule for another worker profile of the same user
    # sch2 = wo1_2.schedules.create!(begin: today.beginning_of_week, end: today.end_of_week)
    # # Create slots for this schedule
    # slt9 = sch2.slots.create!(begin: beginning_of_week.change(:hour => 14, :min => 30, :sec => 0), end: beginning_of_week.change(:hour => 15, :min => 0, :sec => 0))
    # slt10 = sch2.slots.create!(begin: beginning_of_week.change(:hour => 15, :min => 0, :sec => 0), end: beginning_of_week.change(:hour => 15, :min => 30, :sec => 0))
    # slt11 = sch2.slots.create!(begin: beginning_of_week.tomorrow.tomorrow.change(:hour => 8, :min => 30, :sec => 0), end: beginning_of_week.change(:hour => 9, :min => 0, :sec => 0))

    # # Add lof events to be mapped to the created schedules
    # wo1_1.log_events.create!(workstation_id: ws1.id, happened_at: '2016-02-11 10:30:00', worker_role: 'PROCEDURAL ENROUTE', worker_responsability: 'DEPARTURE', operational_status: 'MRC')
    # wo1_1.log_events.create!(workstation_id: ws1.id, happened_at: '2016-02-11 11:00:00', worker_role: 'PROCEDURAL ENROUTE', worker_responsability: 'PLANNING', operational_status: 'SC')
    # wo1_1.log_events.create!(workstation_id: ws2.id, happened_at: '2016-02-12 13:00:00', worker_role: 'PROCEDURAL ENROUTE', worker_responsability: 'PLANNING', operational_status: 'SC')
    # wo1_1.log_events.create!(workstation_id: ws2.id, happened_at: '2016-02-12 15:00:00', worker_role: 'PROCEDURAL ENROUTE', worker_responsability: 'PLANNING', operational_status: 'SC')
  end
end