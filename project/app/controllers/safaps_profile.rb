Narms::App.controllers :safaps_profile do
    
  # Renders the safaps_profile page
  get :index do
        # @shifts = Shift.all

    @safaps_responses = SafapsResponse.all
    render "/safaps_profile/safaps_profile"
  end

end