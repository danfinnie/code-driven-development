class Lolcat < ActiveRecord::Base
  validate :cuteness, presence: true

  def i_call_things
    CentralBureaucracy.file_report
  end

  def i_call_instance_methods
    meth
  end
end
