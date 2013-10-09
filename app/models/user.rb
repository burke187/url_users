class User < ActiveRecord::Base
  validates_presence_of :name, :password, :email
  validates :email, uniqueness: true

  has_many :urls, dependent: :destroy 

  

  def self.authenticate(email, password)
    results = User.where('email=?', email).where('password=?', password)
      if results == []
        false
      else 
        results[0]
      end
  end
end
