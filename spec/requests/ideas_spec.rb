require 'rails_helper'
require 'uri'

RSpec.describe "Ideas", type: :request do

  describe "GET" do
    # it "with parameter returns http success" do
    #   category_name = FactoryBot.build(:category) 
    #   get "/ideas/?category_name=#{URI.encode(category_name.name)}"
    #   expect(response).to have_http_status(200)
    # end

    it "without parameter returns http success" do
      get "/ideas"
      expect(response).to have_http_status(:success)
    end
    
    it "with not registered parameter returns 404" do
      expect{
        get "/ideas/?category_name=#{URI.encode("not_registerd_word")}"
      }.to raise_error(ActionController::RoutingError)
    end
  end 


  describe "POST" do
    it "returns http success when category duplicate" do
      post "/ideas", params:{category_name:"category_name" ,idea:{body:"body"}}
      expect(response).to have_http_status(201)
    end
  end

end

