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

    describe "create with valid info" do
      before do
        fill_in "Message", with: "Foo Bar"
        select "up",       from: "event_status_id"
      end
      
      it "should create an event in the DB" do          
        expect { click_button "Create" }.should change(Event, :count).by(1)
      end
      
      it "should remove event from the DB" do
        click_button "Create"
        expect { click_link "X" }.should change(Event, :count).by(-1)
      end
          
    end
    
    describe "success message after saving" do
      message="Testing Event Creation"
      before do
        fill_in "Message",      with: message
        page.select 'up', :from => 'event_status_id'
        click_button "Create"
      end
      
      it { should have_selector('div.flash.success') }
      it { should have_content(message) }
      it { should have_selector("table") }
    
      describe "delete event from table", :js => true do
                
        it "should remove the event from the UI" do
          click_link "X"
          page.driver.browser.switch_to.alert.accept
          page.should_not have_content(message)
        end
      end
    end
  end
end