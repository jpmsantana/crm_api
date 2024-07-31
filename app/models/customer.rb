# frozen_string_literal: true

class Customer < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :name, presence: true
  validates :surname, presence: true

  def photo_url
    return nil unless photo.attached?

    Rails.application.routes.url_helpers.rails_blob_url(photo, only_path: true)
  end
end
