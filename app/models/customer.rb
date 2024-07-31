# frozen_string_literal: true

class Customer < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :surname, presence: true
end
