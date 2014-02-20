module Payments
  class Factory

    def self.get type, payment, root_url
      @root_url = root_url
      service = case type
        when PaymentTransaction::TYPE_PAYPAL then Payments::Paypal
        when PaymentTransaction::TYPE_DWOLLA then Payments::Dwolla
      end  
      service.new payment root_url
    end

  end
end


