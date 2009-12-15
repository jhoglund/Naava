module TokenModule
  
  def self.included(base)
    base.send :before_create,  :make_token
    base.send :class_variable_set, :@@tokent_type, :secure
    def base.token_type type = :secure
      self.send :class_variable_set, :@@tokent_type, :string
    end
  end
  
  
  def to_param
    token
  end
  
  def token
    write_attribute(:token, read_attribute(:token) || make_token)
  end
  
  private
  
  def secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
  end
  
  def random_string size=4
    str = ""
    size.times { str << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
    str
  end

  def make_token
    self.token = self.class.send(:class_variable_get, :@@tokent_type) == :secure ?  secure_digest(Time.now, (1..10).map{ rand.to_s }) : random_string(8)
  end
end