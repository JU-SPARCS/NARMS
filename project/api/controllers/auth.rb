Narms::Api.controllers :cals, map: 'cals/auth/' do

  post :login do
    user_json = JSON.parse(request.body.read)
    user = User.authenticate(user_json["email"], user_json["password"])

    if (user != nil)
	worker_profiles_list = Array.new		
        user.worker_profiles.each do |wk_profile|
		facility = Facility.find(wk_profile.facility_id)
		wk_profile_formatted = {
			:worker_profile => wk_profile,
			:facility => facility	
		 }
		worker_profiles_list.push wk_profile_formatted
        end

	content_type :json
 	{:success => "True", :worker_profiles => worker_profiles_list}.to_json
    else
	content_type :json
    	{:success => "False"}.to_json
    end
  end
end
