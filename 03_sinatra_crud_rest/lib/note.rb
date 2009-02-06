class Note < ActiveRecord::Base

  validates_presence_of :body

  def permalink
    "/#{id}-#{body.to_s[0...20].downcase.gsub(/[^\w]+/, '-')}"
  end

end