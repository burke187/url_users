require 'uri'

class MyValidator < ActiveModel::Validator
  def validate(record)
    unless record.link =~ /^#{URI::regexp}$/
      record.errors[:link] << 'Please enter a valid URL, asshole.'
    end
  end
end

class Url < ActiveRecord::Base
  validates_with MyValidator
  validates_presence_of :link
  validates :link, uniqueness: true

  belongs_to :user

  def initialize(*args)
    super
    generate_url
    self.count = 0
  end

  def generate_url
    url = []
    possibilities = ('a'..'z').to_a + ('0'..'9').to_a 
    5.times do
      next_char = possibilities.sample
      url << next_char
    end
      self.short_link = url.join
  end

end
