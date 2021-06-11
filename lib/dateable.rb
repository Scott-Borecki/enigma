module Dateable
  def today
    Time.now.strftime('%d%m%y')
  end
end
