# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validation tests' do
    it 'ensures name presence' do
      user = User.create(username: 'pedro111', password: 'xakjs354').valid?
      expect(user).to eq(false)
    end

    it 'ensures username presence' do
      user = User.create(name: 'Pedro', password: 'xakjs354').valid?
      expect(user).to eq(false)
    end

    it 'ensures password presence' do
      user = User.create(name: 'Pedro', username: 'pedro111').valid?
      expect(user).to eq(false)
    end

    it 'should save successfully' do
      user = User.create(name: 'Pedro', username: 'pedro111', password: 'xakjs354').valid?
      expect(user).to eq(true)
    end
  end
end
