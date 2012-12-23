require 'spec_helper'

describe "Static pages" do

  let(:base_title) {"Sample App"};
  
  describe "Home page" do                         #Tells the user what we are describing
    it "should have the content 'Sample App'" do  #What should be on the page
      visit '/static_pages/home';                 #More information for the user
      page.should have_selector('h1', :text => 'Sample App');     #Using the pages variable to check for content
    end

    it 'should have the right title' do
      visit '/static_pages/home';
      page.should have_selector('title', #Checks for html with the given selector element
                              :text => "Ruby on Rails Tutorial #{base_title}");  #Hash with symbol as a key
                                                              #substrings work here as well
    end

    it "should not have a custom page title" do
      visit '/static_pages/home';
      page.should_not have_selector('title', :text => " | Home");
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
                                :text => "#{base_title} | Help");
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
                                :text => "#{base_title} | About");
    end
  end

  #Combine the two tests for the contact page
  describe "Contact Page" do
    it "should have the content \"Contact\" and a correct title" do
      visit "/static_pages/contact";
      page.should have_content("Contact");
      page.should have_selector("title",
                                :text => "#{base_title} | Contact");
    end
  end

end
