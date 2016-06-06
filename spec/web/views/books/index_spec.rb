require_relative '../../../../apps/web/views/books/index'

RSpec.describe Web::Views::Books::Index do
  let(:exposures) { { books: [] } }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/books/index.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #books' do
    expect(view.books).to eq exposures.fetch(:books)
  end

  describe 'when there are no books' do
    it 'shows a placeholder message' do
      expect(rendered).to include('<p class="placeholder">There are no books yet.</p>')
    end
  end

  describe 'when there are books' do
    let(:book1) { Book.new(title: 'Refactoring', author: 'Martin Fowler') }
    let(:book2) { Book.new(title: 'Domain Driven Design', author: 'Eric Evans') }
    let(:exposures) { { books: [book1, book2] } }

    it 'lists them all' do
      expect(rendered.scan(/class="book"/).count).to eq 2
      expect(rendered).to include 'Refactoring' 
    end

    it 'hides the placeholder message' do
      expect(rendered).not_to include "There are no books yet."
    end
  end
end
