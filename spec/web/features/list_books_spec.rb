require 'features_helper'

RSpec.describe 'List books' do
  before do
    repo = BookRepository.new
    repo.clear
    repo.create(Book.new(title: "PoEAA", author: "Martin Fowler"))
    repo.create(Book.new(title: "TDD", author: "Kent Beck"))
  end

  it 'display each book on the page' do
    visit '/books'
    within('#books') do
      expect(page).to have_css(".book", count: 2), 'Expected to find 2 books'
    end
  end
end
