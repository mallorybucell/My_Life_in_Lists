class Item < ActiveRecord::Base
  
  belongs_to  :list
  after_initialize :init

  def init
    self.status   ||= "Incomplete"           #will set the default value only if it's nil
    self.due_time ||= 0
  end
end
