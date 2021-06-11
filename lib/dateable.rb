# This module shares the behavior to return today's date in DDMMYY format
module Dateable
  def today
    Time.now.strftime('%d%m%y')
  end
end
