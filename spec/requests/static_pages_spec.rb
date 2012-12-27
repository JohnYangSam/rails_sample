require 'spec_helper'

describe "Static pages" do

  let(:base_title) {"Sample App"};

  subject { page }
  describe "Home page" do                         #Tells the user what we are describing
    before { visit root_path } # this lets us avoid repetition of visit root_path under each "it...do"
    it { should have_selector('h1', :text => 'Sample App'); }    #Using the pages variable to check for content
    it { should have_selector('title', #Checks for html with the given selector element
                              :text => "Ruby on Rails Tutorial #{base_title}"); } #Hash with symbol as a key
                                                              #substrings work here as well
    it { should_not have_selector('title', :text => " | Home"); }
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit help_path;
      page.should have_content("Help");
    end
 
    it 'should have the right title' do
      visit help_path;
      page.should have_selector('title',
                                :text => "#{base_title} | Help");
    end
  end

  describe "About page" do
    it "should have th content \"About Us\"" do
      visit about_path;
      page.should have_content('About Us');
    end
 
    it 'should have the right title' do
      visit about_path;
      page.should have_selector('title',
                                :text => "#{base_title} | About");
    end
  end

  #Combine the two tests for the contact page
  describe "Contact Page" do
    it "should have the content \"Contact\" and a correct title" do
      visit contact_path;
      page.should have_content("Contact");
      page.should have_selector("title",
                                :text => "#{base_title} | Contact");
    end
  end

end
