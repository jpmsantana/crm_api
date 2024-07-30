require 'rails_helper'

RSpec.describe User do
  it 'has a valid factory' do
    expect(create(:user)).to be_valid
  end

  describe 'validations' do
    before do
      create(:user)
    end

    it { is_expected.to allow_value(Faker::Internet.email).for(:email) }
    it { is_expected.not_to allow_value('random_email@').for(:email) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to have_secure_password }
  end
end
