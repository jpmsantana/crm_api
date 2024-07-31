# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :name, presence: true
  validates :surname, presence: true
end
