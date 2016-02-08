Narms::App.controllers :log_events, :parent => [:workers] do

  get :index do
    render '/log_events/list'
  end

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end
  #
  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end
  #
  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end
  #
  # get '/example' do
  #   'Hello world!'
  # end


end
