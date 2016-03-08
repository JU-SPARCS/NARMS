Narms::Api.controllers :safaps do

  post :safaps_profile, :map => '/safaps-profile' do#, :with => :id do
    content_type :json

    return_message = {}
    request.body.rewind
#        request_data = JSON.parse request.body.read

    begin
        request_data = JSON.parse(request.body.read, :symbolize_names => false)
    rescue JSON::ParserError => e
            # Response
            status 404
            return_message[:status] = '404'
            return_message[:response] = 'error json'
    end

    # Check Errors
    if  !request_data.nil? && request_data.has_key?('id_evaluation') && request_data.has_key?('stress') && request_data.has_key?('fatigue')
        # Init Data from Json
        id_evaluation = request_data['id_evaluation']
        stress = request_data['stress']
        fatigue = request_data['fatigue']

        # Debug
        puts 'id_evaluation : ' + id_evaluation.inspect
        puts 'Stress : ' + stress.inspect
        puts 'Fatigue : ' + fatigue.inspect

        # Create a SafapsResponse Model and store it in the database
        @safaps_response = SafapsResponse.new
        @safaps_response.id_evaluation = id_evaluation
        @safaps_response.stress_indicator = stress
        @safaps_response.fatigue_indicator = fatigue
        @safaps_response.save

        # Response
        status 202
        return_message[:status] = '202'
        return_message[:response] = 'success'
    else
        # Response
        return_message[:status] = '404'
        return_message[:response] = 'error json'
    end

    # Return the response
    return_message.to_json
  end

end
