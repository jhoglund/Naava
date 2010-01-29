class Cash < ActiveRecord::Base
  has_one :payment, :as => :reciept
end
