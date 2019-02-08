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

def initialize(attributes = nil)
  unless attributes.nil? 
    attributes.each {|k, v| send("#{k}=", v)}
  end
end

def table_name_for_insert
  self.class.table_name
end

def col_names_for_insert
  self.class.column_names.delete_if {|col| col == "id"}.join(", ")
end

end