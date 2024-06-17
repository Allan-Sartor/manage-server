# Criação de planos
Plan.create(name: 'Trial', price: 0.0, duration: 'trial', periodicity: 'trial')
Plan.create(name: 'Básico', price: 40.0, duration: 'monthly', periodicity: 'monthly')
Plan.create(name: 'Básico Anual', price: 40.0, duration: 'annual', periodicity: 'annual', discount: 10.0)
Plan.create(name: 'Médio', price: 70.0, duration: 'monthly', periodicity: 'monthly')
Plan.create(name: 'Médio Anual', price: 70.0, duration: 'annual', periodicity: 'annual', discount: 10.0)
Plan.create(name: 'Premium', price: 110.0, duration: 'monthly', periodicity: 'monthly')
Plan.create(name: 'Premium Anual', price: 110.0, duration: 'annual', periodicity: 'annual', discount: 10.0)

# # Criação de usuário e unidade de negócio
# user = User.create!(
#   email: 'admin@example.com',
#   password: 'password',
#   password_confirmation: 'password'
# ) 

# business_unit = BusinessUnit.create!(
#   name: 'Minha Empresa',
#   user: user,
#   plan: Plan.find_by(name: 'Trial')
# )

# # Criação de transações
# Transaction.create!(
#   amount: 100.0,
#   description: 'Venda de produto X',
#   transaction_type: 'income',
#   payment_type: 'cartao',
#   transaction_scope: 'venda',
#   business_unit: business_unit
# )

# Transaction.create!(
#   amount: 50.0,
#   description: 'Compra de material Y',
#   transaction_type: 'expense',
#   payment_type: 'pix',
#   transaction_scope: 'compra',
#   business_unit: business_unit
# )

# Transaction.create!(
#   amount: 200.0,
#   description: 'Receita de serviço Z',
#   transaction_type: 'income',
#   payment_type: 'boleto',
#   transaction_scope: 'receita',
#   business_unit: business_unit
# )

# Transaction.create!(
#   amount: 150.0,
#   description: 'Despesa com manutenção W',
#   transaction_type: 'expense',
#   payment_type: 'transferencia',
#   transaction_scope: 'despesa',
#   business_unit: business_unit
# )
