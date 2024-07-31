# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer do
  it 'has a valid factory' do
    expect(create(:customer)).to be_valid
  end

  describe 'validations' do
    before do
      create(:customer)
    end

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:surname) }
  end
end
