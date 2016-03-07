module PublicIdentifier
  def self.included(base)
    base.class_eval do
      validates_presence_of :pub_id
      before_validation :generate_pub_id, on: :create      
    end
  end

  def generate_pub_id
    self.pub_id = loop do
      s = Digest::SHA1.hexdigest([Time.now, rand].join)[0..10]
      break s unless self.class.exists?(pub_id: s)
    end
  end
end
