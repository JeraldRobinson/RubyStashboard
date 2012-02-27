require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do

    describe "as an admin user" do
      let(:admin) { FactoryGirl.create(:admin) }

      before do
        sign_in admin
        visit users_path
      end

      before(:all) { 60.times { FactoryGirl.create(:user) } }
      #after(:all)  { User.delete_all }

      it { should have_link('Next') }
      it { should have_link('2') }
      it { should have_link('delete') }
      
      #Should not allow admin to delete self
      it { should_not have_link('delete', href: user_path(admin)) }

      it "should list each user" do
        User.all[0..2].each do |user|
          page.should have_selector('li', text: user.name)
        end
      end

      it "should be able to delete another user" do
        expect { click_link('delete') }.to change(User, :count).by(-1)
      end      
    end
  end

#
  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "services table" do
    let(:user1) { FactoryGirl.create(:user) }
    before {sign_in user1}
    before { visit services_path }
    today=get_past_days[0].to_date()
    yesterday=today-1

    it { should have_selector('td', text: "Today" ) }
    it { should have_selector('td', text: yesterday.to_s ) }
    it { should have_selector('title', text: "Your Services") }

    describe "without services" do
      it { should have_link("Create Service", href: new_service_path ) }
    end
    
    describe "with services" do
      #let(:user) { FactoryGirl.create(:user) }
      #before {sign_in user}
      
      let!(:s1) { FactoryGirl.create(:service, user: user1, description: "foo") }
      let!(:s2) { FactoryGirl.create(:service, user: user1, description: "bar") }

      before { visit services_path }
      it { should have_selector('th',    text: "Service") }
      it { should have_content(s1.name) }
      it { should have_content(s2.name) }
      
      it "should render the user's services" do
        user1.feed.each do |item|
          page.should have_selector("tr##{item.id}", text: item.name)
        end
      end
      
    end
  end

  describe "signup process" do
    before { visit signup_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Sign up" }.not_to change(User, :count)
      end
    end

    describe "with valid information" , js: true do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button "Sign up" }.to change(User, :count).by(1)
    
      end
    end
  end

#

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Edit user") }
      it { should have_selector('title', text: "Edit user") }
    end

    describe "with invalid information" do
      let(:error) { 'Unable to save record' }
      before { click_button "Update" }
      it { should have_content(error) }
    end

    describe "with valid information" do
      let(:user)      { FactoryGirl.create(:user) }
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",         with: new_name
        fill_in "Email",        with: new_email
        fill_in "Password",     with: user.password
        fill_in "Confirmation", with: user.password
        click_button "Update"
      end

      it { should have_selector('div.flash.success') }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end