Narms::Api.controllers :cals, map: 'cals/auth/' do

  post :login do
    user_json = JSON.parse(request.body.read)
    puts user_json

    user = User.authenticate(user_json["email"], user_json["password"])
    if (user != nil)
	wk_profiles_array = Array.new		

	wk_profiles = user.worker_profiles
        wk_profiles.each do |wk_profile|
		facility = Facility.find(wk_profile.facility_id)
		wk_profile_formatted = {
			:worker_profile_pub_id => wk_profile.pub_id,
			:facility_pub_id => facility.pub_id	
		 }
		wk_profiles_array.push wk_profile_formatted
        end


	content_type :json
 	{:success => "True", :worker_profiles => wk_profiles_array}.to_json()
    else
	content_type :json
    	{:success => "False"}.to_json()
    end
  end
end
