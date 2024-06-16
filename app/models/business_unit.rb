# frozen_string_literal: true

class BusinessUnit < ApplicationRecord
  # Associações
  belongs_to :user
  belongs_to :plan
  has_many :clients, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :inventory_items, dependent: :destroy

  # Validações
  validates :name, presence: true

  # Callbacks
  # Define a data de vencimento inicial do pagamento após a criação da unidade de negócios
  after_create :set_initial_payment_due_date

  # Define a data de vencimento inicial do pagamento com base na duração do plano (mensal ou anual)
  # e permite que o usuário escolha o dia de vencimento
  def set_initial_payment_due_date(payment_due_day = nil)
    duration = plan.duration == 'annual' ? 1.year.from_now : 1.month.from_now
    due_date = payment_due_day ? Time.zone.today.next_month.change(day: payment_due_day) : duration
    update(payment_due_date: due_date, notification_date: due_date - 15.days)
  end

  # Verifica se a unidade de negócios está ativa com base no status do pagamento e na data de vencimento
  def active?
    payment_status == 'paid' && payment_due_date > Time.current
  end

  # Verifica e atualiza o status de pagamento da unidade de negócios
  def check_payment_status
    return unless payment_due_date < Time.current

    # Se o pagamento estiver atrasado, atualiza o status para 'overdue'
    update(payment_status: 'overdue') if payment_status == 'paid'

    # Se o pagamento estiver atrasado por mais de 15 dias, suspende o serviço
    return unless payment_due_date < 15.days.ago

    update(payment_status: 'suspended')
    UserMailer.service_suspended(user).deliver_later
  end

  # Método de classe para gerar pagamentos mensais para todas as unidades de negócios
  def self.generate_monthly_payments
    find_each do |business_unit|
      next unless business_unit.payment_due_date <= Time.current

      payment_service = PaymentService.new(business_unit, {
                                             amount: business_unit.plan.price,
                                             description: "Assinatura para #{business_unit.plan.name}",
                                             payment_method_id: 'pix', # Ou o método de pagamento padrão
                                             email: business_unit.user.email,
                                             identification_type: 'CPF',
                                             identification_number: business_unit.user.cpf, # Ajuste conforme necessário
                                             token: business_unit.user.payment_token, # Ajuste conforme necessário
                                             installments: 1
                                           })

      result = payment_service.process_payment

      if result[:status] == 'approved'
        duration = business_unit.plan.duration == 'annual' ? 1.year.from_now : 1.month.from_now
        business_unit.update(payment_status: 'paid', payment_due_date: duration, notification_date: duration - 15.days)
      else
        business_unit.update(payment_status: 'payment_failed')
        UserMailer.payment_failed(business_unit.user, result[:error]).deliver_later
      end
    end
  end
end
