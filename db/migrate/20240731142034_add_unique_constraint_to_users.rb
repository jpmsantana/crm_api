# frozen_string_literal: true

class AddUniqueConstraintToUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :users, 'LOWER(email)', unique: true, name: 'index_users_on_lowercase_email'
  end
end
