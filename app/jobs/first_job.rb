class FirstJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.bd_user_soon
  end
  
end
