class Attendant < ActiveRecord::Base
  belongs_to :participant
  belongs_to :session
end
