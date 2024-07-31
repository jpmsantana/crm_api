# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :customers, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: URI::MailTo::EMAIL_REGEXP
end
