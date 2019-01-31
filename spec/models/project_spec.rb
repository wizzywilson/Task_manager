# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'Project created by FactoryBot' do
    it { expect(FactoryBot.create(:project)).to be_valid }
  end

  describe 'Associations' do
    it { should have_many(:project_users) }
    it { should have_many(:users).through(:project_users) }
  end

  describe 'Validations' do
    it { should validate_uniqueness_of(:name) }
  end

  describe 'Nested attributes for' do
    it do
      should accept_nested_attributes_for(:project_users)
        .allow_destroy(true)
    end
  end
end
