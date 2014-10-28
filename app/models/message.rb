class Message < ActiveRecord::Base
  @@waiting = true

  def self.waiting
    @@waiting
  end

  def self.waiting=(state)
    @@waiting = state
  end
end
