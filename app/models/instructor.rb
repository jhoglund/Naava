class Instructor < ActiveRecord::Base
  has_many :courses
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  def first_name
    name.split.first
  end
end
