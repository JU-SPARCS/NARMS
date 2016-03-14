Narms::Api.controllers :cals, map: 'cals/:facility_id' do
  before do
    @facility = Facility.find_by_pub_id(params[:facility_id])
    ensure_identified_by_token!(params[:token])
  end

  post :users do
    @facility.worker_profiles.create!(
      name: params[:name],
      first_name: params[:first_name],
      date_of_birth: params[:date_of_birth]
    ).pub_id
  end

  post :workstations do
    @facility.workstations.create!(
      name: params[:name]
    ).pub_id
  end

  post :log_events do
    Events::Log.create!(
      worker_profile: WorkerProfile.find_by_pub_id(params[:user_id]),
      workstation: Workstation.find_by_pub_id(params[:workstation_id]),
      happened_at: params[:happened_at],
      event_type: params[:event_type],
      worker_role: params[:worker_role],
      worker_responsability: params[:worker_responsability],
      operational_status: params[:operational_status]
    ).happened_at
  end

  post :airspace_segments do
    @facility.airspace_segments.create!(
      name: params[:name]
    ).pub_id
  end
end
