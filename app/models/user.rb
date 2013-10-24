class User < ActiveRecord::Base
  has_one   :location
  validates_presence_of :name
  #validates_uniqueness_of :name, :scope => :last_name
 # def before_save
  #  raise self.inspect
 # end

#def full_name
#  name = self.name + " "
#  name += "#{self.email}. " unless self.email.nil?
 # name += self.last_name
 # name
#end

#ActiveRecord::Base.class_eval do
 # def self.skip_callback(callback, &block)
 #   method = instance_method(callback)
 #   remove_method(callback) if respond_to?(callback)
 #   define_method(callback){ true }
 #   begin
 #    result = yield
  #  ensure
  #    remove_method(callback)
  #    define_method(callback, method)
  #  end
  #  result
 # end
#end
end