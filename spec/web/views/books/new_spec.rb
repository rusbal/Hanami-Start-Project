require 'spec_helper'
require_relative '../../../../apps/web/views/books/new'

class NewBookParams < Hanami::Action::Params
  param :book do
    param :title, presence: true
    param :author, presence: true
  end
end

RSpec.describe Web::Views::Books::New do
  let(:params)    { NewBookParams.new({}) }
  let(:exposures) { { params: params } }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/books/new.html.erb') }
  let(:view)      { Web::Views::Books::New.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'displays list of errors when params contains errors' do
    params.valid?

    expect(rendered).to include('There was a problem with your submission')
    expect(rendered).to include('title is required')
    expect(rendered).to include('author is required')
  end
end
