require 'pry'

class Transfer
  
  attr_accessor :sender, :receiver, :status, :amount

  @@all = []

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
    @@all << self
  end
  
  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if valid? && @amount <= @sender.balance
      if @status == "pending"
        @sender.balance -= @amount
        @receiver.balance += @amount
        @status = "complete"
      else
        @status = "rejected"  
      end  
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
      #binding.pry
    end  
  end  

  def reverse_transfer
    if @status == "complete"
      @receiver.balance -= @amount
      @sender.balance += @amount
      @status = "reversed"
    else
      #
    end    
  end  

end
