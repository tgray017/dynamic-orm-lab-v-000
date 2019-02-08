require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'pry'

class InteractiveRecord
  
def self.table_name
  self.to_s.downcase.pluralize
end

def self.column_names
  sql = "pragma table_info('#{table_name}')"
  DB[:conn].execute(sql).collect {|hash| hash["name"]}
end

self.column_names.each {|col_name| attr_accessor col_name.to_sym}

def initialize(attributes = nil)
  unless attributes.nil? 
    attributes.each {|k, v| send("#{k}=", v)}
  end
end

end