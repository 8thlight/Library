require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    it "should redirect to home page" do
      response.code.should eq("200")
    end
  end

  describe "#destroy" do
    it "redirects to root after signing out" do
      get 'destroy'
      response.should redirect_to root_url
    end
  end

  describe "GET new" do
    it "directs to the authentication verification" do
      get 'new'
      response.should redirect_to '/auth/google_oauth2'
    end
  end

  describe "#open_id" do
    it "redirects to admin" do
      get 'open_id'
      response.should redirect_to '/auth/admin'
    end
  end

  describe "#failure" do
    it "redirects to to root url" do
      get 'failure'
      stub(:humanize)
      response.should redirect_to root_url
    end
  end
end
