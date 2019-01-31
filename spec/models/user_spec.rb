# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Employee creation through FactoryBot' do
    it { expect(FactoryBot.create(:user, role: :employee)).to be_valid }
  end

  describe 'Admin creation' do
    it { expect(FactoryBot.create(:user, role: :admin)).to be_valid }
  end

  describe 'Associations' do
    it { should have_many(:projects) }
    it { should have_many(:project_users) }
  end

  describe 'Enums' do
    it { should define_enum_for(:role).with_values(%I[admin employee]) }
  end
end
