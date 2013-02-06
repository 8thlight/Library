require 'spec_helper'

describe RegisterBookController do

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
  end

  describe "GET '_form'" do
    it "returns http success" do
      get :_form
      response.should be_success
    end
  end
end
