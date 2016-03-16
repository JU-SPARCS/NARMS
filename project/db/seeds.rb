# Seeding file to use to fill the database with starting data

def print_facility(facility)
  ws = facility.workstations.all.map { |_ws| [_ws.name, _ws.pub_id] }
  wp = facility.worker_profiles.all.find_each.map { |_wp| [_wp.name, _wp.pub_id] }
  token = facility.tokens.first.try(:token)

  puts "#{facility.name}, id: #{facility.pub_id}, tok: #{token}"
  puts "- Workstations:"
  ws.each { |_ws| puts "  - #{_ws.join(', ')}" }
  puts "- Worker profiles:"
  wp.each { |_ws| puts "  - #{_ws.join(', ')}" }
end

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

    today = Date.today.to_time
    beginning_of_week = today.beginning_of_week
    
    # Creating recipient 1

  # SAMO
    recipient = ThirdParties::Recipient.create!(name: 'SAMO')

  # NORDICA
    nordica = recipient.organizations.create!(name: 'Nordica')

    facility = Facility.create!(name: 'Nordica 1') do |facility|
      facility.workstations.new(name: "#{facility.name} - Bay A - 1")
      facility.workstations.new(name: "#{facility.name} - Bay A - 2")
    end
    nordica.token_holders.create!(tokenable_r: facility, name: facility.name)
    print_facility facility

    facility = Facility.create!(name: 'Nordica 2') do |facility|
      facility.workstations.new(name: "#{facility.name} - Bay A - 1")
      facility.workstations.new(name: "#{facility.name} - Bay A - 2")

      facility.worker_profiles.new(first_name: sm1.first_name, name: sm1.name, user: sm1)
      facility.worker_profiles.new(first_name: sm2.first_name, name: sm2.name, user: sm2)
      facility.worker_profiles.new(first_name: atco1.first_name, name: atco1.name, user: atco1)
      facility.worker_profiles.new(first_name: atco2.first_name, name: atco2.name, user: atco2)
      facility.worker_profiles.new(first_name: atco3.first_name, name: atco3.name, user: atco3)
      facility.worker_profiles.new(first_name: atco4.first_name, name: atco4.name, user: atco4)
      facility.worker_profiles.new(first_name: atco5.first_name, name: atco5.name, user: atco5)
    end
    nordica.token_holders.create!(tokenable_r: facility, name: facility.name)
    print_facility facility

  # NEXTJET
    nextjet = recipient.organizations.create!(name: 'NextJet')
    facility = Facility.create!(name: 'NextJet Jonkoping') do |facility|
      facility.workstations.new(name: "#{facility.name} - Bay A - 1")
      facility.workstations.new(name: "#{facility.name} - Bay A - 2")

      facility.worker_profiles.new(first_name: sm1.first_name, name: sm1.name, user: sm1)
      facility.worker_profiles.new(first_name: atco1.first_name, name: atco1.name, user: atco1)
    end
    nextjet.token_holders.create!(tokenable_r: facility, name: facility.name)
    print_facility facility 

  end
end