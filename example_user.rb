class User
  #automatically creates getter and setter methods for 
  #name and email instance variables (same as Java and C variables)
  #In Rails they are mainly important because they can be accessed in views.
  attr_accessor :name, :email;

  #Special keyword (like Java or C Ctor)
  def initialize(attributes = {}) #allows for default nil initialization
    @name   = attributes[:name];
    @email  = attributes[:email];
  end

  def formatted_email
    return "#{@name} <#{@email}>";
  end
end
