Narms::App.controllers :worker do
  get :index, :with => :id do
    render '/worker/profile'
  end
end
