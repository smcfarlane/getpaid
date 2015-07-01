
######################################################
############# Delete Everything First ################
######################################################

User.delete_all
Account.delete_all
Address.delete_all
Email.delete_all
Organization.delete_all
Phone.delete_all
Partner.delete_all
Project.delete_all
ProjectOrg.delete_all
Invoice.delete_all
LineItem.delete_all

######################################################

def create_org name: nil
  name ||= "#{Faker::Company.name} #{Faker::Company.suffix}"
  Organization.create(name: name)
end

def create_address sa: nil, sa2: nil, city: nil, state: nil, zip: nil
  sa ||= Faker::Address.street_address
  sa2 ||= Faker::Address.secondary_address
  city ||= Faker::Address.city
  state ||= Faker::Address.state_abbr
  zip ||= Faker::Address.zip_code
  Address.create(street_address: sa, street_address2: sa2, city: city, state: state, zip: zip)
end

def create_phone phone_number: nil
  phone_number ||= Faker::PhoneNumber.phone_number
  Phone.create(phone_number: phone_number)
end

def create_email email: nil
  email ||= Faker::Internet.email
  Email.create(email: email)
end

def create_project name: nil, identifier: nil, start_date: nil, end_date: nil, owner: nil
  name ||= "Project #{Faker::Lorem.words(2).join(' ')}"
  identifier ||= Faker::Company.duns_number
  start_date ||= Faker::Date.between(Date.today, 2.month.from_now)
  end_date ||= Faker::Date.between(2.month.from_now, 1.year.from_now)
  Project.create(name: name, identifier: identifier, start_date: start_date, end_date: end_date, owner: owner)
end

def create_invoice project_id: nil, to_org_id: nil, identifier: nil, date: nil, due_date: nil, discount: nil, discount_timeframe: nil, notes: nil
  identifier ||= Faker::Company.duns_number
  date ||= Faker::Date.between(Date.today, 2.weeks.from_now)
  discount ||= 2
  discount_timeframe ||= 30
  due_date ||= date + discount_timeframe.days
  notes ||= Faker::Lorem.paragraph
  Invoice.create(project_id: project_id, identifier: identifier, date: date, due_date: due_date, discount: discount, discount_timeframe: discount_timeframe, notes: notes, to_org_id: to_org_id)
end

def create_line_items invoice_id: nil, item: nil, description: nil, amount: nil
  item ||= Faker::Commerce.product_name
  description ||= Faker::Lorem.sentences(2).join(' ')
  amount ||= Faker::Commerce.price
  LineItem.create(invoice_id: invoice_id, item: item, description: description, amount: amount)
end

# create users
5.times do |i|
  fname = Faker::Name.first_name
  lname = Faker::Name.last_name
  # org for user
    org = create_org
  # add info to org
    a1 = create_address
    a1.update_attribute :addressable, org
    e1 = create_email
    e1.update_attribute :emailable, org
    p1 = create_phone
    p1.update_attribute :callable, org
  # email for user
    email = "#{fname}.#{lname}@#{org.name.gsub(/\W/, '')}.com"
  # create user account
    account = Account.create!(email: email, password: 'password', password_confirmation: 'password')
  # create user info
    user = User.create(first_name: fname, last_name: lname, organization: org, account: account)
  # add an address, email, and phone number to user
    a = create_address
    a.update_attribute :addressable, user
    e = create_email email: email
    e.update_attribute :emailable, user
    p = create_phone
    p.update_attribute :callable, user
end

# create more orgs
20.times do |i|
  # org for user
    org = create_org
  # add info to org
    a1 = create_address
    a1.update_attribute :addressable, org
    e1 = create_email
    e1.update_attribute :emailable, org
    p1 = create_phone
    p1.update_attribute :callable, org
end

# Create clients and vendors with projects
Organization.all.each do |org|
  orgs = Organization.all.to_a
  orgs.shuffle!
  5.times do
    new_client = orgs.shift
    org.clients << new_client unless new_client == org
  end
  5.times do
    new_vendor = orgs.shift
    org.vendors << new_vendor unless new_vendor == org
  end
  org.clients.each do |client|
    2.times do
      project = create_project owner: org
      org.projects << project
      client.projects << project
      2.times do
        invoice = create_invoice to_org_id: client.id
        2.times do
          create_line_items invoice_id: invoice.id
        end
        project.invoices << invoice
      end
    end
  end
  org.vendors.each do |vendor|
    2.times do
      project = create_project owner: org
      org.projects << project
      vendor.projects << project
    end
  end
end