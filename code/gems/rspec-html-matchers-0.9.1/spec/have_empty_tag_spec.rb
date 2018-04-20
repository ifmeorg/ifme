# encoding: UTF-8
require 'spec_helper'

describe 'have_empty_tag' do
  context 'when single element' do
    asset 'single_element'

    it { expect(rendered).to have_empty_tag('div') }
    it { expect(rendered).to have_empty_tag('div', :class => "foo") }
    it { expect(rendered).to have_empty_tag('div', :class => "bar") }
    it { expect(rendered).to have_empty_tag('div', :class => "foo bar") }
  end

  context 'when paragraphs' do
    asset 'paragraphs'

    it { expect(rendered).to_not have_empty_tag('p') }
  end

  context 'when ordered list' do
    asset 'ordered_list'

    it { expect(rendered).to_not have_empty_tag('html') }
    it { expect(rendered).to_not have_empty_tag('body') }
    it { expect(rendered).to_not have_empty_tag('ol') }
    it { expect(rendered).to_not have_empty_tag('ol', :class => 'menu') }
    it { expect(rendered).to_not have_empty_tag('li') }
  end
end
