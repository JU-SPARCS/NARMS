Narms::Api.controllers :workstations, map: 'cals/workstations/' do

  get :index do 
	workstations = Array.new
	Workstation.all.each do |workstation|
		workstation_formatted = {
			:public_id => workstation.pub_id,
			:name => workstation.name,
			:fac_pub_id => workstation.facility.pub_id
		}
		workstations.push workstation_formatted	
	end

	content_type :json
	{:success => "True", :workstations => workstations}.to_json

  end

end
