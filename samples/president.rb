class Bunker < ActiveRecord::Base
  validate :password, secure: true
  validate :location, :protected => true

  def alert_staff
    Staff.alert_all
  end

  def alert_president
    SecretService.stand_down
    alert_staff || go_crazy
  end
end
