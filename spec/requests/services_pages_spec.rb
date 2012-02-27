require 'spec_helper'

describe "Service pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in(user) }

  describe "service creation" do
    before { visit new_service_path }

    describe "with invalid information" do

      it "should not create a service" do
        expect { click_button "Create" }.should_not change(Service, :count)
      end

      describe "error messages" do
        let(:error) { 'Unable to save record' }
        before { click_button "Create" }
        it { should have_content(error) } 
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Foo Bar"
        fill_in "Description",  with: "foobar description"
        fill_in "url",          with: "www.foobar.com"
      end
      
      it "should create a service in the DB" do          
        expect { click_button "Create" }.should change(Service, :count).by(1)
      end      
    end
    
    describe "after saving a service" do
      name="Testing Service Creation"
      before do
        fill_in "Name",         with: name
        fill_in "Description",  with: "foobar description"
        fill_in "url",          with: "www.foobar.com"
        click_button "Create"
      end
      
      it { should have_selector('div.flash.success') }
      it { should have_link(name,    href: service_events_path(Service.find_by_name(name).id)) }
    end    
  end
end