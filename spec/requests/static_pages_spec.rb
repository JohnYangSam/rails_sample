require 'spec_helper'

describe "Static pages" do
  
  describe "Home page" do                         #Tells the user what we are describing
    it "should have the content 'Sample App'" do  #What should be on the page
      visit '/static_pages/home';                 #More information for the user
      page.should have_content('Sample App');     #Using the pages variable to check for content
    end

    it 'should have the right title' do
      visit '/static_pages/home';
      page.should have_selector('title', #Checks for html with the given selector element
                              :text => "Sample App | Home");  #Hash with symbol as a key
                                                              #substrings work here as well
    end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit "/static_pages/help";
      page.should have_content("Help");
    end
 
    it 'should have the right title' do
      visit '/static_pages/help';
      page.should have_selector('title',
                                :text => "Sample App | Help");
    end
  end

  describe "About page" do
    it "should have th content \"About Us\"" do
      visit '/static_pages/about';
      page.should have_content('About Us');
    end
 
    it 'should have the right title' do
      visit '/static_pages/about';
      page.should have_selector('title',
                                :text => "Sample App | About");
    end
  end

end
