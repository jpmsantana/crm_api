json.user do
  json.partial! 'shared/user', user: @user
end
json.jwt @token
