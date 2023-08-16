# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Score, type: :model do
  context 'model validation tests' do
    user = FactoryBot.create(:user)

    it 'ensures user_id presence' do
      score = Score.create(score: 100).valid?
      expect(score).to eq(false)
    end

    it 'ensures score presence' do
      score = Score.create(user_id: user.id).valid?
      expect(score).to eq(false)
    end

    it 'should save successfully' do
      expect(user.save).to eq(true), user.errors.full_messages.to_sentence
      score = Score.create(score: 100, user_id: user.id).valid?
      expect(score).to eq(true)
    end
  end
end
