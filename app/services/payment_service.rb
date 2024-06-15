# frozen_string_literal: true

class PaymentService
  def initialize(user, params)
    @user = user
    @params = params
    @sdk = Mercadopago::SDK.new(ENV.fetch('MERCADO_PAGO_ACCESS_TOKEN', nil))
  end

  def process_payment
    payment_data = {
      transaction_amount: @params[:amount].to_f,
      description: @params[:description],
      payment_method_id: @params[:payment_method_id],
      payer: {
        email: @params[:email],
        identification: {
          type: @params[:identification_type],
          number: @params[:identification_number]
        }
      }
    }

    if @params[:payment_method_id] == 'pix'
      create_pix_payment(payment_data)
    elsif ['visa', 'mastercard', 'amex'].include?(@params[:payment_method_id])
      payment_data[:token] = @params[:token]
      payment_data[:installments] = @params[:installments] || 1
      create_card_payment(payment_data)
    else
      { status: 'failure', error: 'Método de pagamento inválido' }
    end
  end

  private

  def create_pix_payment(payment_data)
    payment_data[:payment_method_id] = 'pix'
    payment = @sdk.payment.create(payment_data)
    handle_payment_response(payment)
  end

  def create_card_payment(payment_data)
    payment = @sdk.payment.create(payment_data)
    handle_payment_response(payment)
  end

  def handle_payment_response(payment)
    if payment[:status] == 'approved'
      @user.update(payment_status: 'paid', payment_due_date: 1.month.from_now)
      { status: 'approved', payment_id: payment[:id] }
    else
      { status: 'failure', error: payment[:error] }
    end
  end
end
