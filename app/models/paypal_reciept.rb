class PaypalReciept < ActiveRecord::Base
  has_one :payment, :as => :reciept
end
