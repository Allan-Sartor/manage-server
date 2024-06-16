# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def payment_failed(user, error)
    @user = user
    @error = error
    mail(to: @user.email, subject: 'Falha no pagamento da sua assinatura')
  end

  def service_canceled(user)
    @user = user
    mail(to: @user.email, subject: 'Serviço cancelado por falta de pagamento')
  end
end
