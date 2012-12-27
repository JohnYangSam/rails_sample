require 'spec_helper'

describe "full_title" do
  it "should include the page title" do
    # "reg exp".should =~ /exp/
    # This means the string should include the regex
    full_title("foo").should =~ /foo/;
  end

  it "should include the base title" do
    # Remember "^" matches the beginning of line
    full_title("foo").should =~ /^Ruby on Rails Tutorial Sample App/;
  end

  it "should not include a bar for the home page" do
    full_title("").should_not =~ /\|/;
  end
end
