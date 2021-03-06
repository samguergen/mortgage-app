

#based on a 30 year mortgage.

class Mortgage

  def initialize(total_price, downpayment, annual_interest_rate, loan_amount )
    @total_price = total_price.to_f
	@downpayment = downpayment.to_f
	@monthly_interest = (annual_interest_rate.to_f / 12) / 100
	@loan_amount = loan_amount.to_f
	@number_of_payments = 360.00
  end

  def calculator
  	nominator = (@monthly_interest * @loan_amount * ((1+ @monthly_interest)** @number_of_payments))
  	denominator = (((1+ @monthly_interest)** @number_of_payments) -1 )
	monthly_payment = (@monthly_interest * @loan_amount * ((1+ @monthly_interest)** @number_of_payments)) / (((1+ @monthly_interest)** @number_of_payments) -1 )
  	
  	monthly_interest = monthly_payment - (@total_price / @number_of_payments)
  	monthly_principal = monthly_payment - monthly_interest

  	remaining_balance = @total_price
  	
  	remaining_interest = remaining_balance * (annual_interest_rate.to_f / 12)
  	remaining_balance =  monthly_payment - remaining_interest 


  	puts nominator
  	puts denominator
  	puts monthly_payment
  	puts monthly_interest
  	puts monthly_principal
  end

end


new_mortgage = Mortgage.new(280000, 30000, 5, 250000)
new_mortgage.calculator
