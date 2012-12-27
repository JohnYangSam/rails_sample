
# The support directory files are automatically "require"d 
# inside the other spec tests (i.e. files in requests, helpers, etc.) 

# using "include" as a module mixin at the instance level
# an "extend" would mixin at the class level
# and a "require" simply adds another file and checks to make
# sure that it has not already been added already like an "include"
# statement in most other languages, so we don't want that here
include ApplicationHelper;
# This is take care of by the ApplicationHelper
# include statement
# def full_title(page_title)
#   base_title = "Ruby on Rails Tutorial Sample App";
#   if(page_title.empty?())
#     return base_title;
#   else
#    return "#{base_title} | #{page_title}"
#   end
# end
