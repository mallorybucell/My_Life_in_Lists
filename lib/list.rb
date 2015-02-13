class List < ActiveRecord::Base

  has_many  :items
  after_initialize :init

  def init
    self.ongoing = false if self.ongoing.nil?
    self.status  ||= "Incomplete" 
    self.due_date ||= 01/01/2100
    self.due_time ||= 0  
  end
end