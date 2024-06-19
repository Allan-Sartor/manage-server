require_relative '../lib/cnpj_generator'

# Helper to ensure unique records
def create_unique_user(attrs)
  User.find_or_create_by!(email: attrs[:email]) do |user|
    user.name = attrs[:name]
    user.password = attrs[:password]
    user.password_confirmation = attrs[:password_confirmation]
  end
end

def create_unique_business_unit(user, attrs)
  user.business_units.find_or_create_by!(cnpj: attrs[:cnpj]) do |bu|
    bu.name = attrs[:name]
    bu.plan = attrs[:plan]
    bu.state_registration = attrs[:state_registration]
    bu.municipal_registration = attrs[:municipal_registration]
    bu.legal_name = attrs[:legal_name]
    bu.trade_name = attrs[:trade_name]
  end
end

# Plans
plans = [
  { name: 'Trial', price: 0, duration: 'trial', discount: 0, periodicity: 'trial', max_business_units: 1 },
  { name: 'Basic Monthly', price: 40, duration: 'monthly', discount: 0, periodicity: 'monthly', max_business_units: 1 },
  { name: 'Basic Annual', price: 40 * 12 * 0.9, duration: 'annual', discount: 10, periodicity: 'annual', max_business_units: 1 },
  { name: 'Medium Monthly', price: 70, duration: 'monthly', discount: 0, periodicity: 'monthly', max_business_units: 3 },
  { name: 'Medium Annual', price: 70 * 12 * 0.85, duration: 'annual', discount: 15, periodicity: 'annual', max_business_units: 3 },
  { name: 'Premium Monthly', price: 110, duration: 'monthly', discount: 0, periodicity: 'monthly', max_business_units: 5 },
  { name: 'Premium Annual', price: 110 * 12 * 0.8, duration: 'annual', discount: 20, periodicity: 'annual', max_business_units: 5 }
]

plans.each do |plan_attrs|
  Plan.create!(plan_attrs)
end

# Users
users = [
  { name: 'Trial User', email: 'trial_user@example.com', password: 'password' },
  { name: 'Basic User', email: 'basic_user@example.com', password: 'password' },
  { name: 'Medium User', email: 'medium_user@example.com', password: 'password' },
  { name: 'Premium User', email: 'premium_user@example.com', password: 'password' }
]

created_users = users.map { |attrs| create_unique_user(attrs) }

# Business Units and Transactions
business_units = [
  { user: created_users[0], name: 'Trial Business', plan: Plan.find_by(name: 'Trial'), cnpj: CnpjGenerator.generate },
  { user: created_users[1], name: 'Basic Business', plan: Plan.find_by(name: 'Basic Monthly'), cnpj: CnpjGenerator.generate },
  { user: created_users[2], name: 'Medium Business 1', plan: Plan.find_by(name: 'Medium Monthly'), cnpj: CnpjGenerator.generate },
  { user: created_users[2], name: 'Medium Business 2', plan: Plan.find_by(name: 'Medium Monthly'), cnpj: CnpjGenerator.generate },
  { user: created_users[3], name: 'Premium Business 1', plan: Plan.find_by(name: 'Premium Monthly'), cnpj: CnpjGenerator.generate },
  { user: created_users[3], name: 'Premium Business 2', plan: Plan.find_by(name: 'Premium Monthly'), cnpj: CnpjGenerator.generate }
]

created_business_units = business_units.map do |attrs|
  create_unique_business_unit(attrs[:user], attrs.merge(state_registration: '123456789', municipal_registration: '987654321', legal_name: "#{attrs[:name]} LTDA", trade_name: attrs[:name]))
end

# Clients
clients = [
  { business_unit: created_business_units[1], name: 'Client One', email: 'client1@basicbiz.com' },
  { business_unit: created_business_units[2], name: 'Client Two', email: 'client2@mediumbiz1.com' },
  { business_unit: created_business_units[4], name: 'Client Three', email: 'client3@premiumbiz1.com' }
]

created_clients = clients.map do |attrs|
  Client.create!(attrs)
end

# Transactions
transactions = [
  { business_unit: created_business_units[1], amount: 100, description: 'Product sale', transaction_type: 'income', payment_type: 'credit_card', status: 'paid', transaction_scope: 'venda', client: created_clients[0] },
  { business_unit: created_business_units[2], amount: 200, description: 'Material purchase', transaction_type: 'expense', payment_type: 'debit_card', status: 'paid', transaction_scope: 'compra', client: created_clients[1] },
  { business_unit: created_business_units[4], amount: 300, description: 'Service payment', transaction_type: 'income', payment_type: 'pix', status: 'paid', transaction_scope: 'receita', client: created_clients[2] },
  { business_unit: created_business_units[4], amount: 400, description: 'Inventory adjustment', transaction_type: 'expense', payment_type: 'bank_transfer', status: 'pending', transaction_scope: 'inventory_adjustment' },
  { business_unit: created_business_units[3], amount: 150, description: 'Dividends payment', transaction_type: 'income', payment_type: 'cash', status: 'paid', transaction_scope: 'dividends', client: created_clients[1] },
  { business_unit: created_business_units[3], amount: 500, description: 'Dividends payment', transaction_type: 'income', payment_type: 'cash', status: 'paid', transaction_scope: 'dividends', client: created_clients[2] },
  { business_unit: created_business_units[2], amount: 50, description: 'Non-client product sale', transaction_type: 'income', payment_type: 'cash', status: 'paid', transaction_scope: 'venda' }
]

transactions.each do |attrs|
  Transaction.create!(attrs)
end
