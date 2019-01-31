# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'task created by FactoryBot' do
    it { expect(FactoryBot.create(:task, :Done)).to be_valid }
  end

  describe 'Associations' do
    it { should belong_to(:project_user) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'Enums' do
    it do
      should define_enum_for(:status)
        .with_values(%I[Not_Started In_Progress Done])
    end
  end
end
