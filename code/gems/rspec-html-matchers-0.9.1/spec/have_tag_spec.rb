# encoding: utf-8
require 'spec_helper'

describe 'have_tag' do
  context "through css selector" do
    asset 'search_and_submit'

    it "should have right description" do
      expect(have_tag('div').description).to eq 'have at least 1 element matching "div"'
      expect(have_tag('div.class').description).to eq 'have at least 1 element matching "div.class"'
      expect(have_tag('div#id').description).to eq 'have at least 1 element matching "div#id"'
    end

    it "should find tags" do
      expect(rendered).to have_tag('div')
      expect(rendered).to have_tag(:div)
      expect(rendered).to have_tag('div#div')
      expect(rendered).to have_tag('p.paragraph')
      expect(rendered).to have_tag('div p strong')
    end

    it "should not find tags" do
      expect(rendered).to_not have_tag('span')
      expect(rendered).to_not have_tag(:span)
      expect(rendered).to_not have_tag('span#id')
      expect(rendered).to_not have_tag('span#class')
      expect(rendered).to_not have_tag('div div span')
    end

    it "should not find tags and display appropriate message" do
      expect {
        expect(rendered).to have_tag('span')
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto have at least 1 element matching "span", found 0.}
      )
      expect {
        expect(rendered).to have_tag('span#some_id')
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto have at least 1 element matching "span#some_id", found 0.}
      )
      expect {
        expect(rendered).to have_tag('span.some_class')
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto have at least 1 element matching "span.some_class", found 0.}
      )
    end

    it "should find unexpected tags and display appropriate message" do
      expect {
        expect(rendered).to_not have_tag('div')
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto NOT have element matching "div", found 2.}
      )
      expect {
        expect(rendered).to_not have_tag('div#div')
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto NOT have element matching "div#div", found 1.}
      )
      expect {
        expect(rendered).to_not have_tag('p.paragraph')
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto NOT have element matching "p.paragraph", found 1.}
      )
    end

    context "with additional HTML attributes(:with option)" do
      it "should find tags" do
        expect(rendered).to have_tag('input#search',:with => {:type => "text"})
        expect(rendered).to have_tag(:input ,:with => {:type => "submit", :value => "Save"})
      end

      it "should find tags that have classes specified via array(or string)" do
        expect(rendered).to have_tag('div',:with => {:class => %w(class-one class-two)})
        expect(rendered).to have_tag('div',:with => {:class => 'class-two class-one'})
      end

      it "should not find tags that have classes specified via array" do
        expect(rendered).to_not have_tag('div',:with => {:class => %w(class-other class-two)})
      end

      it "should not find tags that have classes specified via array and display appropriate message" do
        expect {
          expect(rendered).to have_tag('div',:with => {:class => %w(class-other class-two)})
        }.to raise_spec_error(
          %Q{expected following:\n#{rendered}\nto have at least 1 element matching "div.class-other.class-two", found 0.}
        )
        expect {
          expect(rendered).to have_tag('div',:with => {:class => 'class-other class-two'})
        }.to raise_spec_error(
          %Q{expected following:\n#{rendered}\nto have at least 1 element matching "div.class-other.class-two", found 0.}
        )
      end

      it "should not find tags" do
        expect(rendered).to_not have_tag('input#search',:with => {:type => "some_other_type"})
        expect(rendered).to_not have_tag(:input, :with => {:type => "some_other_type"})
      end

      it "should not find tags and display appropriate message" do
        expect {
          expect(rendered).to have_tag('input#search',:with => {:type => "some_other_type"})
        }.to raise_spec_error(
          %Q{expected following:\n#{rendered}\nto have at least 1 element matching "input#search[type='some_other_type']", found 0.}
        )
      end

      it "should find unexpected tags and display appropriate message" do
        expect {
          expect(rendered).to_not have_tag('input#search',:with => {:type => "text"})
        }.to raise_spec_error(
          %Q{expected following:\n#{rendered}\nto NOT have element matching "input#search[type='text']", found 1.}
        )
      end

    end

    context "with additional HTML attributes (:without option)" do
      asset 'single_element'

      it "should find tags that have classes specified via array (or string)" do
        expect(rendered).to_not have_tag('div', :without => { :class => %w(foo bar) })
        expect(rendered).to_not have_tag('div', :without => { :class => 'foo bar' })
        expect(rendered).to_not have_tag('div', :without => { :class => 'foo' })
        expect(rendered).to_not have_tag('div', :without => { :class => 'bar' })
      end

      it "should not find tags that have classes specified via array (or string)" do
        expect(rendered).to have_tag('div', :without => { :class => %w(foo baz) })
        expect(rendered).to have_tag('div', :without => { :class => 'foo baz' })
        expect(rendered).to have_tag('div', :without => { :class => 'baz' })
      end
    end
  end

  context "by count" do
    asset 'paragraphs'

    it "should have right description" do
      expect(have_tag('div', :count => 100500).description).to eq 'have 100500 element(s) matching "div"'
    end

    it "should find tags" do
      expect(rendered).to have_tag('p', :count => 3)
      expect(rendered).to have_tag('p', :count => 2..3)
    end

    it "should find tags when :minimum specified" do
      expect(rendered).to have_tag('p', :min      => 3)
      expect(rendered).to have_tag('p', :minimum  => 2)
    end

    it "should find tags when :maximum specified" do
      expect(rendered).to have_tag('p', :max      => 4)
      expect(rendered).to have_tag('p', :maximum  => 3)
    end

    it "should not find tags(with :count, :minimum or :maximum specified)" do
      expect(rendered).to_not have_tag('p', :count   => 10)
      expect(rendered).to_not have_tag('p', :count   => 4..8)
      expect(rendered).to_not have_tag('p', :min     => 11)
      expect(rendered).to_not have_tag('p', :minimum => 10)
      expect(rendered).to_not have_tag('p', :max     => 2)
      expect(rendered).to_not have_tag('p', :maximum => 2)
    end

    it "should not find tags and display appropriate message(with :count)" do
      expect {
        expect(rendered).to have_tag('p', :count => 10)
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto have 10 element(s) matching "p", found 3.}
      )

      expect {
        expect(rendered).to have_tag('p', :count => 4..8)
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto have at least 4 and at most 8 element(s) matching "p", found 3.}
      )
    end

    it "should find unexpected tags and display appropriate message(with :count)" do
      expect {
        expect(rendered).to_not have_tag('p', :count => 3)
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto NOT have 3 element(s) matching "p", but found.}
      )

      expect {
        expect(rendered).to_not have_tag('p', :count => 1..3)
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto NOT have at least 1 and at most 3 element(s) matching "p", but found 3.}
      )
    end

    it "should not find tags and display appropriate message(with :minimum)" do
      expect {
        expect(rendered).to have_tag('p', :min => 100)
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto have at least 100 element(s) matching "p", found 3.}
      )
      expect {
        expect(rendered).to have_tag('p', :minimum => 100)
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto have at least 100 element(s) matching "p", found 3.}
      )
    end

    it "should find unexpected tags and display appropriate message(with :minimum)" do
      expect {
        expect(rendered).to_not have_tag('p', :min => 2)
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto NOT have at least 2 element(s) matching "p", but found 3.}
      )
      expect {
        expect(rendered).to_not have_tag('p', :minimum => 2)
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto NOT have at least 2 element(s) matching "p", but found 3.}
      )
    end

    it "should not find tags and display appropriate message(with :maximum)" do
      expect {
        expect(rendered).to have_tag('p', :max => 2)
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto have at most 2 element(s) matching "p", found 3.}
      )
      expect { expect(rendered).to have_tag('p', :maximum => 2) }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto have at most 2 element(s) matching "p", found 3.}
      )
    end

    it "should find unexpected tags and display appropriate message(with :maximum)" do
      expect {
        expect(rendered).to_not have_tag('p', :max => 5)
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto NOT have at most 5 element(s) matching "p", but found 3.}
      )
      expect {
        expect(rendered).to_not have_tag('p', :maximum => 5)
      }.to raise_spec_error(
        %Q{expected following:\n#{rendered}\nto NOT have at most 5 element(s) matching "p", but found 3.}
      )
    end

    it "should raise error when wrong params specified" do
      expect {
        expect(rendered).to have_tag('div', :count => 'string')
      }.to raise_error(/wrong :count/)

      wrong_params_error_msg_1 = ':count with :minimum or :maximum has no sence!'

      expect {
        expect(rendered).to have_tag('div', :count => 2, :minimum => 1)
      }.to raise_error(wrong_params_error_msg_1)

      expect {
        expect(rendered).to have_tag('div', :count => 2, :min     => 1)
      }.to raise_error(wrong_params_error_msg_1)

      expect {
        expect(rendered).to have_tag('div', :count => 2, :maximum => 1)
      }.to raise_error(wrong_params_error_msg_1)

      expect {
        expect(rendered).to have_tag('div', :count => 2, :max     => 1)
      }.to raise_error(wrong_params_error_msg_1)

      wrong_params_error_msg_2 = ':minimum should be less than :maximum!'

      expect {
        expect(rendered).to have_tag('div', :minimum => 2, :maximum => 1)
      }.to raise_error(wrong_params_error_msg_2)

      [ 4..1, -2..6, 'a'..'z', 3..-9 ].each do |range|
        expect {
          expect(rendered).to have_tag('div', :count => range )
        }.to raise_error("Your :count range(#{range.to_s}) has no sence!")
      end
    end
  end

  context "with :text/:seen specified" do
    asset 'quotes'

    context 'using standard syntax' do

      it "should find tags" do
        expect(rendered).to have_tag('div',  :text => 'sample text')
        expect(rendered).to have_tag('p',    :text => 'one')
        expect(rendered).to have_tag('div',  :text => /SAMPLE/i)
        expect(rendered).to have_tag('span', :text => "sample with 'single' quotes")
        expect(rendered).to have_tag('span', :text => %Q{sample with 'single' and "double" quotes})
        expect(rendered).to have_tag('span', :text => /sample with 'single' and "double" quotes/)

        expect(rendered).to have_tag('p',    :seen => 'content with ignored spaces around')
        expect(rendered).to have_tag('p',    :seen => 'content with ignored spaces in')
        expect(rendered).to have_tag('p',    :seen => 'content with nbsp  and  spaces   around')

        unless Nokogiri::VERSION == '1.5.11'
          expect(rendered).to have_tag('p',    :text => 'content with nbsp')
        end
        expect(rendered).to have_tag('pre',  :text => " 1. bla   \n 2. bla ")
      end

      it "should find with unicode text specified" do
        expect {
          expect(rendered).to have_tag('a', :text => "học")
        }.not_to raise_error

        expect(rendered).to have_tag('a', :text => "học")
      end

      it "should not find tags" do
        expect(rendered).to_not have_tag('p',      :text => 'text does not present')
        expect(rendered).to_not have_tag('strong', :text => 'text does not present')
        expect(rendered).to_not have_tag('p',      :text => /text does not present/)
        expect(rendered).to_not have_tag('strong', :text => /text does not present/)
        expect(rendered).to_not have_tag('p',      :text => 'contentwith nbsp')

        expect(rendered).to_not have_tag('p',      :seen => 'content with ignoredspaces around')
        expect(rendered).to_not have_tag('p',      :seen => 'content with ignored  spaces around')
        expect(rendered).to_not have_tag('p',      :seen => 'content withignored spaces in')
        expect(rendered).to_not have_tag('p',      :seen => 'contentwith nbsp')
        expect(rendered).to_not have_tag('p',      :seen => 'content with nbsp  and  spaces  around')

        expect(rendered).to_not have_tag('pre',    :text => "1. bla\n2. bla")
      end

      it "should invoke #to_s method for :text" do
        expect {
          expect(rendered).to_not have_tag('p', :text => 100500 )
          expect(rendered).to have_tag('p', :text => 315 )
        }.to_not raise_exception
      end

      it "should not find tags and display appropriate message" do
        # TODO make diffable,maybe...
        expect {
          expect(rendered).to have_tag('div', :text => 'SAMPLE text')
        }.to raise_spec_error(
          %Q{"SAMPLE text" expected within "div" in following template:\n#{rendered}}
        )
        expect {
          expect(rendered).to have_tag('div', :text => /SAMPLE tekzt/i)
        }.to raise_spec_error(
          %Q{/SAMPLE tekzt/i regexp expected within "div" in following template:\n#{rendered}}
        )
      end

      it "should find unexpected tags and display appropriate message" do
        expect {
          expect(rendered).to_not have_tag('div', :text => 'sample text')
        }.to raise_spec_error(
          %Q{"sample text" unexpected within "div" in following template:\n#{rendered}\nbut was found.}
        )
        expect {
          expect(rendered).to_not have_tag('div', :text => /SAMPLE text/i)
        }.to raise_spec_error(
          %Q{/SAMPLE text/i regexp unexpected within "div" in following template:\n#{rendered}\nbut was found.}
        )
      end

    end

    context 'using alternative syntax(with_text/without_text)' do

      it "should raise exception when used outside any other tag matcher" do
        expect {
          with_text 'sample text'
        }.to raise_error(StandardError,/inside "have_tag"/)
        expect {
          without_text 'sample text'
        }.to raise_error(StandardError,/inside "have_tag"/)
      end

      it "should raise exception when used with block" do
        expect {
          expect(rendered).to have_tag('div') do
            with_text 'sample text' do
              puts 'bla'
            end
          end
        }.to raise_error(ArgumentError,/does not accept block/)

        expect {
          expect(rendered).to have_tag('div') do
            with_text 'sample text', proc { puts 'bla' }
          end
        }.to raise_error(ArgumentError)

        expect {
          expect(rendered).to have_tag('div') do
            without_text 'sample text' do
              puts 'bla'
            end
          end
        }.to raise_error(ArgumentError,/does not accept block/)

        expect {
          expect(rendered).to have_tag('div') do
            without_text 'sample text', proc { puts 'bla' }
          end
        }.to raise_error(ArgumentError)
      end

      it "should find tags" do
        expect(rendered).to have_tag('div') do
          with_text 'sample text'
        end

        expect(rendered).to have_tag('p') do
          with_text 'one'
        end

        expect(rendered).to have_tag('div') do
          with_text /SAMPLE/i
        end

        expect(rendered).to have_tag('span') do
          with_text "sample with 'single' quotes"
        end

        expect(rendered).to have_tag('span') do
          with_text %Q{sample with 'single' and "double" quotes}
        end

        expect(rendered).to have_tag('span') do
          with_text /sample with 'single' and "double" quotes/
        end

        unless Nokogiri::VERSION == '1.5.11'
          expect(rendered).to have_tag('p') do
            with_text 'content with nbsp'
          end
        end

        expect(rendered).to have_tag('pre') do
          with_text " 1. bla   \n 2. bla "
        end
      end

      it "should not find tags" do
        expect(rendered).to have_tag('p') do
          but_without_text 'text does not present'
          without_text 'text does not present'
        end

        expect(rendered).to have_tag('p') do
          but_without_text /text does not present/
          without_text /text does not present/
        end

        expect(rendered).to have_tag('p') do
          but_without_text 'contentwith nbsp'
          without_text 'contentwith nbsp'
        end

        expect(rendered).to have_tag('pre') do
          but_without_text "1. bla\n2. bla"
          without_text "1. bla\n2. bla"
        end
      end

      it "should not find tags and display appropriate message" do
        expect {
          expect(rendered).to have_tag('div') do
            with_text 'SAMPLE text'
          end
        }.to raise_spec_error(
          /"SAMPLE text" expected within "div" in following template:/
        )

        expect {
          expect(rendered).to have_tag('div') do
            with_text /SAMPLE tekzt/i
          end
        }.to raise_spec_error(
          %r{/SAMPLE tekzt/i regexp expected within "div" in following template:}
        )
      end

      it "should find unexpected tags and display appropriate message" do
        expect {
          expect(rendered).to have_tag('div') do
            without_text 'sample text'
          end
        }.to raise_spec_error(
          %r{"sample text" unexpected within "div" in following template:}
        )

        expect {
          expect(rendered).to have_tag('div') do
            without_text /SAMPLE text/i
          end
        }.to raise_spec_error(
          %r{/SAMPLE text/i regexp unexpected within "div" in following template:}
        )
      end

    end

  end

  context "mixed matching" do
    asset 'special'

    it "should find tags by count and exact content" do
      expect(rendered).to have_tag("td", :text => 'a', :count => 3)
    end

    it "should find tags by count and rough content(regexp)" do
      expect(rendered).to have_tag("td", :text => /user/, :count => 3)
    end

    it "should find tags with exact content and additional attributes" do
      expect(rendered).to have_tag("td", :text => 'a', :with => { :id => "special" })
      expect(rendered).to_not have_tag("td", :text => 'a', :with => { :id => "other-special" })
    end

    it "should find tags with rough content and additional attributes" do
      expect(rendered).to have_tag("td", :text => /user/, :with => { :id => "other-special" })
      expect(rendered).to_not have_tag("td", :text => /user/, :with => { :id => "special" })
    end

    it "should find tags with count and additional attributes" do
      expect(rendered).to have_tag("div", :with => { :class => "one" }, :count => 6)
      expect(rendered).to have_tag("div", :with => { :class => "two" }, :count => 3)
    end

    it "should find tags with count, exact text and additional attributes" do
      expect(rendered).to have_tag("div", :with => { :class => "one" }, :count => 3, :text => 'text')
      expect(rendered).to_not have_tag("div", :with => { :class => "one" }, :count => 5, :text => 'text')
      expect(rendered).to_not have_tag("div", :with => { :class => "one" }, :count => 3, :text => 'other text')
      expect(rendered).to_not have_tag("div", :with => { :class => "two" }, :count => 3, :text => 'text')
    end

    it "should find tags with count, regexp text and additional attributes" do
      expect(rendered).to have_tag("div", :with => { :class => "one" }, :count => 2, :text => /bla/)
      expect(rendered).to have_tag("div", :with => { :class => "two" }, :count => 1, :text => /bla/)
      expect(rendered).to_not have_tag("div", :with => { :class => "one" }, :count => 5, :text => /bla/)
      expect(rendered).to_not have_tag("div", :with => { :class => "one" }, :count => 6, :text => /other bla/)
    end
  end

  context "nested matching:" do
    asset 'ordered_list'

    it "should find tags" do
      expect(rendered).to have_tag('ol') {
        with_tag('li', :text  => 'list item 1')
        with_tag('li', :text  => 'list item 2')
        with_tag('li', :text  => 'list item 3')
        with_tag('li', :count => 3)
        with_tag('li', :count => 2..3)
        with_tag('li', :min   => 2)
        with_tag('li', :max   => 6)
      }
    end

    it "should not find tags" do
      expect(rendered).to have_tag('ol') {
        without_tag('div')
        without_tag('li', :count => 2)
        without_tag('li', :count => 4..8)
        without_tag('li', :min => 100)
        without_tag('li', :max => 2)
        without_tag('li', :text => 'blabla')
        without_tag('li', :text => /list item (?!\d)/)
      }
    end

    it "should handle do; end" do
      expect {
        expect(rendered).to have_tag('ol') do
          with_tag('div')
        end
      }.to raise_spec_error(/have at least 1 element matching "div", found 0/)
    end

    it "should not find tags and display appropriate message" do
      ordered_list_regexp = rendered[/<ol.*<\/ol>/m].gsub(/(\n?\s{2,}|\n\s?)/,'\n*\s*')

      expect {
        expect(rendered).to have_tag('ol') { with_tag('li'); with_tag('div') }
      }.to raise_spec_error(/to have at least 1 element matching "div", found 0/)

      expect {
        expect(rendered).to have_tag('ol') { with_tag('li'); with_tag('li', :count => 10) }
      }.to raise_spec_error(/to have 10 element\(s\) matching "li", found 3/)

      expect {
        expect(rendered).to have_tag('ol') { with_tag('li'); with_tag('li', :text => /SAMPLE text/i) }
      }.to raise_spec_error(/\/SAMPLE text\/i regexp expected within "li"/)
    end
  end

  context "deep nesting" do
    asset 'multiple_lists'

    it "should allow deep nesting" do
      expect(rendered).to have_tag('div') do
        with_tag 'ul.numeric' do
          with_tag 'li#one'
        end
      end
    end

    it "should clear context between nested tags" do
      expect(rendered).to have_tag('div') do |div|
        expect(div).to have_tag 'ul.numeric'
        expect(div).to have_tag 'ul.alpha'
      end
    end

    it "should narrow context when deep nesting" do
      expect do
        expect(rendered).to have_tag('div') do |div|
          expect(div).to have_tag 'ul.numeric' do |ul_numeric|
            expect(ul_numeric).to have_tag 'li#aye'
          end
        end
      end .to raise_spec_error(/at least 1 element matching "li#aye", found 0/)
    end

    it "should narrow context for with_text" do
      expect do
        expect(rendered).to have_tag('div') do |div|
          expect(div).to have_tag 'ul.numeric' do
            with_text 'A'
          end
        end
      end .to raise_spec_error(/"A" expected within "ul.numeric"/)
    end
  end

  context 'find nested tags' do
    asset 'nested_matchers'

    it 'with block parameters' do
      expect(rendered).to have_tag('div#one') do |a|
        expect(a).to have_tag 'p.find_me', :count => 2

        expect(a).to have_tag 'b.nested', :count => 3
        expect(a).to have_tag('p.deep-nesting', :count => 1) do |b|
          expect(b).to have_tag 'b.nested', :count => 2
        end
      end
    end

    it 'with short_hand methods' do
      expect(rendered).to have_tag('div#one') do
        with_tag 'p.find_me', :count => 2

        with_tag 'b.nested', :count => 3
        with_tag('p.deep-nesting', :count => 1) do
          with_tag 'b.nested', :count => 2
        end
      end
    end
  end

  context "backwards compatibility for unnamed arguments" do
    asset 'quotes'

    context "string as second argument" do

      it "should map a string argument to :text => string" do
        expect(rendered).to have_tag('div',  'sample text')
      end

    end

    context "Regexp as second argument" do

      it "should match against a valid Regexp" do
        expect(rendered).to have_tag('div',  /sample\s/)
      end

      it "should not match against an invalid Regexp" do
        expect(rendered).to_not have_tag('div',  /not matching/)
      end
    end
  end

end
