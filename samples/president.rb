class Bunker < ActiveRecord::Base
  validate :password, secure: true
  validate :location, :protected => true

  def alert_staff
    Staff.alert_all
  end

  def alert_president
    alert_staff
    SecretService.stand_down
    President.alert
  end
end
