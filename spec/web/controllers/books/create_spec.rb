require 'spec_helper'
require_relative '../../../../apps/web/controllers/books/create'

RSpec.describe Web::Controllers::Books::Create do
  let(:action) { described_class.new }

  after do
    BookRepository.new.clear
  end

  describe 'with valid params' do
    let(:params) { Hash[ book: { title: 'Confident Ruby', author: 'Avdi Grimm' } ] }

    it 'creates a new book' do
      action.call(params)
      expect(action.book.id).to be_truthy
    end

    it 'redirects the user to the books listing' do
      response = action.call(params)
      expect(response[0]).to eq(302)
      expect(response[1]['Location']).to eq '/books'
    end
  end

  describe 'with invalid params' do
    let(:params) { Hash[book: { title: "" }] }

    it 're-renders the books#new view' do
      response = action.call(params)
      expect(response[0]).to eq(200)
    end

    it 'sets errors attribute accordingly' do
      action.call(params)

      expect(action.params.valid?).to be_falsy
      expect(action.errors.for('book.title')).not_to be_empty
      expect(action.errors.for('book.author')).not_to be_empty
    end
  end
end
