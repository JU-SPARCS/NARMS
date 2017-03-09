Narms::Api.controllers :cals, map: 'cals/:facility_id' do
  before do
    @facility = Facility.find_by_pub_id(params[:facility_id])
#    ensure_identified_by_token!(@json[:token])
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
    log_event = JSON.parse(request.body.read)
    worker_profile = WorkerProfile.find_by_pub_id(log_event["user_id"])
    workstation = Workstation.find_by_pub_id(log_event["workstation_id"])

    puts log_event
    puts worker_profile
    puts workstation 
   
    if (worker_profile != nil && workstation != nil)
	Events::Log.create!(
      		worker_profile: worker_profile,
      		workstation: workstation,
      		happened_at: log_event["happened_at"],
      		event_type: log_event["event_type:"],
      		worker_role: log_event["worker_role"],
      		worker_responsability: log_event["worker_responsability"],
      		operational_status: log_event["operational_status"]
    	).happened_at

    	content_type :json
    	{:success => "True"}.to_json
    else
	content_type :json
        {:success => "False"}.to_json
    end
  end

  post :airspace_segments do
    @facility.airspace_segments.create!(
      name: params[:name]
    ).pub_id
  end
end
