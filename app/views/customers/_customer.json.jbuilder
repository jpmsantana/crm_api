json.(customer, :id, :name, :surname, :photo_url)
json.user do
  json.partial! 'shared/user', user: customer.user
end
