require 'spec_helper'

describe "Event pages" do

  subject { page }

  let(:status) { FactoryGirl.create(:status) }
  let(:user) { FactoryGirl.create(:user) }
  let(:service) { FactoryGirl.create(:service)} 

  before { user.save }
  
  let!(:service) do 
   FactoryGirl.create(:service, user: user)
  end
  
  let!(:status_up) do
    FactoryGirl.create(:status, name: "up")
  end
  
  before do
    sign_in(user)
    visit services_path
    click_link (service.name)
  end
  
  it {should have_link("Create Event")}
  
  describe "event creation" do
    
    before { click_link "Create Event" }

    describe "with invalid information" do

      it "should not create an event" do
        expect { click_button "Create" }.should_not change(Event, :count)
      end

      describe "error messages" do
        let(:error) { 'Unable to save record' }
        before { click_button "Create" }
        it { should have_content(error) } 
      end
    end

    describe "with valid information" do
      before do
        fill_in "Message", with: "Foo Bar"
        select "up",       from: "event_status_id"
      end
      
      it "should create an event in the DB" do          
        expect { click_button "Create" }.should change(Event, :count).by(1)
      end      
    end
    
    describe "after saving an event" do
      message="Testing Event Creation"
      before do
        fill_in "Message",      with: message
        page.select 'up', :from => 'event_status_id'
        click_button "Create"
      end
      
      it { should have_selector('div.flash.success') }
      it { should have_content(message) }
    end    
  end
end