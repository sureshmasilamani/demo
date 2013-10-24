# Copyright © 2005-2010 Srishti Software Applications Pvt Ltd.
# This product includes software developed by Srishti Software Applications Pvt ltd.
# All rights reserved
module Paras
  module ExternalId
    def self.included(base)
      super
      base.class_eval do
        before_create  :before_save_extid     # if Ambient.conf.get(:ext_ids)[self.class.humanize.to_sym] && Ambient.conf.get(:ext_ids)[self.class.humanize.to_sym][:save_type] == :aaaa
        # after save we need to change, currently it will not work in production (it will go to infinite loop)
        # after_save   :after_save_extid      # if Ambient.conf.get(:ext_ids)[:patient][:save_type] == :bbbb
      end
      
      def before_save_extid
       # generate_ext_id if Ambient.conf.get(:ext_ids)[self.class.table_name.to_sym] && Ambient.conf.get(:ext_ids)[self.class.table_name.to_sym][:ext_id_type] == 'auto' && Ambient.conf.get(:ext_ids)[self.class.table_name.to_sym][:save_type] == :before_save
      end
      
      def after_save_extid
        #generate_ext_id if Ambient.conf.get(:ext_ids)[self.class.table_name.to_sym] && Ambient.conf.get(:ext_ids)[self.class.table_name.to_sym][:ext_id_type] == 'auto' && Ambient.conf.get(:ext_ids)[self.class.table_name.to_sym][:save_type] == :after_save
      end
      
      def generate_ext_id(operation=nil)
       # raise Ambient.conf.get(:ext_ids)[self.class.table_name.to_sym][:configuration].inspect
        Ambient.conf.get(:ext_ids)[self.class.table_name.to_sym][:configuration].each do |each_conf|
          if !each_conf.has_key?(:conditions) || each_conf[:conditions].call(self)
            return set_extid(each_conf,operation)
          end
        end
#        raise ExternalIdException  
      end
      
      def set_extid(each_conf,operation)
        ## self.extids.by_narration(a[:narration]) -- doubt : patient is not bounded to location but some other are bounded to location.
#        raise each_conf[:sequence].has_key?(:institute_specific).inspect
        if !each_conf[:sequence].has_key?(:institute_specific)
          institution_flag = false
          extid = self.respond_to?(:location_id) ? self.location.extids.find_by_narration_and_current_reset_value(each_conf[:sequence][:narration].call(self), each_conf[:sequence][:reset_format].call(self))  : Extid.find_by_narration_and_current_reset_value(each_conf[:sequence][:narration].call(self), each_conf[:sequence][:reset_format].call(self))  
        else
          if each_conf[:sequence][:institute_specific] == false
            institution_flag = false
            extid = Extid.find_by_narration_and_current_reset_value(each_conf[:sequence][:narration].call(self), each_conf[:sequence][:reset_format].call(self))
          else
            institution_flag = true
            extid = self.respond_to?(:location_id) ? self.location.healthcare_institution.extids.find_by_narration_and_current_reset_value(each_conf[:sequence][:narration].call(self), each_conf[:sequence][:reset_format].call(self))  : Extid.find_by_narration_and_current_reset_value(each_conf[:sequence][:narration].call(self), each_conf[:sequence][:reset_format].call(self))  
          end
        end
        
        if !extid.blank?
          sequence, reset_value =  next_sequence(each_conf,extid)
          Extid.skip_callback(:before_save_extid) do
            extid.update_attributes(:current_value => sequence, :current_reset_value => reset_value) 
          end
        else
          sequence =  each_conf[:sequence][:start_with].to_i
          Extid.skip_callback(:before_save_extid) do
            extid = Extid.create(:narration=> each_conf[:sequence][:narration].call(self),
            :current_value => each_conf[:sequence][:start_with].to_i,
            :current_reset_value => each_conf[:sequence][:reset_format].call(self), 
            :location_id => self.respond_to?(:location_id) ? self.location_id : '',:healthcare_institution_id => (institution_flag ? self.location.healthcare_institution_id : ''))
          end
        end
        puts '--------------------------------'
        #puts each_conf[:id_format].call(extid, sequence)
        puts '---------------------------------'
        if operation == 'get'
          sequence, reset_value =  next_sequence(each_conf,extid)
          return each_conf[:id_format].call(self, sequence)
        else
          self.extid = each_conf[:id_format].call(self, sequence)
          return self.extid
        end
      end
      
      def next_extid
        generate_ext_id('get')
      end
      
      
      def next_sequence(each_conf, ext_obj)
        reset_value = ext_obj.current_reset_value
        if each_conf[:sequence][:reset_format].call(self).blank? || reset_value == each_conf[:sequence][:reset_format].call(self)
          sequence = ext_obj.current_value.to_i + each_conf[:sequence][:increment_by].to_i
        else
          sequence = each_conf[:sequence][:start_with].to_i
        end
        return sequence, (each_conf[:sequence].has_key?(:reset_format) ? each_conf[:sequence][:reset_format].call(self) : nil)
      end
      
    end 
  end
  
  class ExternalIdException < Exception
  end
  
end



# Apply the Mix-in to ActiveRecord::Base
ActiveRecord::Base.class_eval do
  include Paras::ExternalId
end


ActiveRecord::Base.class_eval do
  def self.skip_callback(callback, &block)
    method = instance_method(callback)
    remove_method(callback) if respond_to?(callback)
    define_method(callback){ true }
    begin
      result = yield
    ensure
      remove_method(callback)
      define_method(callback, method)
    end
    result
  end
end