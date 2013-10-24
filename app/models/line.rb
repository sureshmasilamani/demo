class Person
  include ActiveModel::Serialization
 
  attr_accessor :attributes
  def initialize(attributes)
    @attributes = attributes
  end
end