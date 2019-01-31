# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectUser, type: :model do
  describe 'PM creation through FactoryBot' do
    it do
      expect(FactoryBot.create(:project_user, designation: :PM)).to be_valid
    end
  end

  describe 'DEV creation through FactoryBot' do
    it do
      expect(FactoryBot.create(:project_user, designation: :DEV)).to be_valid
    end
  end

  describe 'Associations' do
    it { should belong_to(:project) }
    it { should belong_to(:user) }
    it { should have_many(:tasks) }
    it { should belong_to(:assigner).with_foreign_key('assigned_by') }
  end

  describe 'Nested attributes for' do
    it { should accept_nested_attributes_for(:tasks) }
  end

  describe 'Enums' do
    it { should define_enum_for(:designation).with_values(%I[PM DEV]) }
  end
end
