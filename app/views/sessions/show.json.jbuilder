# frozen_string_literal: true

json.user do
  json.partial! 'shared/user', user: current_user
end
