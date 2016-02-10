require 'spec_helper'

RSpec.describe "/log_events" do
  pending "add some examples to #{__FILE__}" do
    before do
      get "/log_events"
    end

    it "returns hello world" do
      expect(last_response.body).to eq "Hello World"
    end
  end
end
