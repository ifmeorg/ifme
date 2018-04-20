require 'spec_helper'

describe "have_form" do
  asset 'form'

  context "without &block" do
    it "should find form" do
      # sanity check
      expect(rendered).to have_form("/books", :post)
      expect(rendered).to have_form("/books", "post", :with => { :id => "new_book", :class => %w(book formtastic) })
    end

    it "should not find form" do
      expect(rendered).to_not have_form("/some_url", :post)
      expect(rendered).to_not have_form("/books", :get)
    end
  end

  context "with &block" do
    context "with_select" do
      it "should find select" do
        expect(rendered).to have_form("/books", :post) do
          with_select("book[publisher_id]", :with => { :id => "book_publisher_id" })
          with_select("book[publisher_id]", :with => { :id => "book_publisher_id" })
        end
      end

      it "should not find select" do
        expect(rendered).to have_form("/books", :post) do
          without_select("book[publisher_id]", :with => { :id => "other_id" })
          without_select("koob[publisher_id]", :with => { :id => "book_publisher_id" })
        end
      end

      context "with_option" do
        it "should find options" do
          expect(rendered).to have_form("/books", :post) do
            with_select("book[publisher_id]") do
              with_option(nil)
              with_option("The Pragmatic Bookshelf", :selected => true)
              with_option(/sitepoint/,2)
              with_option("O'Reilly", 3, :selected => false)
            end
          end
        end

        it "should not find options" do
          expect(rendered).to have_form("/books", :post) do
            with_select("book[publisher_id]") do
              without_option("blah blah")
              without_option("O'Reilly", 3, :selected => true)
              without_option("O'Reilly", 100500)
            end
          end
        end
      end

      context "with_button" do
        it "should find button" do
          expect(rendered).to have_form("/books", :post) do
            with_button("Cancel Book")
          end
        end

        it "should not find button" do
          expect(rendered).to have_form("/books", :post) do
            without_button("Create Book")
          end
        end
      end
    end

    context "with_hidden_field" do
      it "should find hidden field" do
        expect(rendered).to have_form("/books", :post) do
          with_hidden_field("authenticity_token")
          with_hidden_field("authenticity_token", '718WaH76RAbIVhDlnOidgew62ikn8IUCOyWLEqjw1GE=')
        end
      end

      it "should not find hidden field" do
        expect(rendered).to have_form("/books", :post) do
          without_hidden_field('user_id')
          without_hidden_field('authenticity_token', 'blabla')
        end
      end
    end

    context "with_text_field" do
      it "should find text field" do
        expect(rendered).to have_form("/books", :post) do
          with_text_field('book[title]')
          with_text_field('book[title]',nil)
          with_text_field('book[author]','Authorname')
        end
      end

      it "should not find text field" do
        expect(rendered).to have_form("/books", :post) do
          without_text_field('book[title]','title does not exist')
          without_text_field('book[authoRR]')
          without_text_field('book[blabla]')
        end
      end
    end

    context "with_email_field" do
      it "should find email field" do
        expect(rendered).to have_form("/books", :post) do
          with_email_field('user[email]')
          with_email_field('user[email]', 'email@example.com')
          with_email_field('user[email_confirmation]', nil)
        end
      end

      it "should not find email field" do
        expect(rendered).to have_form("/books", :post) do
          without_email_field('book[author]','Authorname')
          without_email_field('user[emaiL]')
          without_email_field('user[apocalyptiq]')
        end
      end
    end

    context "with_url_field" do
      it "should find url field" do
        expect(rendered).to have_form("/books", :post) do
          with_url_field('user[url]')
          with_url_field('user[url]', 'http://user.com')
        end
      end

      it "should not find url field" do
        expect(rendered).to have_form("/books", :post) do
          without_url_field('user[url]','Authorname')
          without_url_field('user[emaiL]')
          without_url_field('user[apocalyptiq]')
        end
      end
    end

    context "with_number_field" do
      it "should find number field" do
        expect(rendered).to have_form("/books", :post) do
          with_number_field('number')
          with_number_field('number_defined', 3)
          with_number_field('number_defined', '3')
        end
      end

      it "should not find number field" do
        expect(rendered).to have_form("/books", :post) do
          without_number_field('number',400)
          without_number_field('number','400')
          without_number_field('user[emaiL]')
          without_number_field('user[apocalyptiq]')
        end
      end
    end

    context "with_range_field" do
      it "should find range field" do
        expect(rendered).to have_form("/books", :post) do
          with_range_field('range1', 1, 3)
          with_range_field('range1','1','3')
          with_range_field('range2', 1, 3, :with => { :value => 2 } )
          with_range_field('range2', 1, 3, :with => { :value => '2' } )
        end
      end

      it "should not find range field" do
        expect(rendered).to have_form("/books", :post) do
          without_range_field('number')
          without_range_field('range1', 1, 5)
          without_range_field('range2', 1, 3, :with => { :value => 5 } )
        end
      end
    end

    context "with_date_field" do
      it "should find date field" do
        expect(rendered).to have_form("/books", :post) do
          with_date_field(:date)
          with_date_field(:date, 'book_date')
          with_date_field(:month, 'book_month', :with => { :value => 5 })
          with_date_field(:week,'book_week')
          with_date_field(:time, 'book_time')
          with_date_field(:datetime, 'book_datetime')
          with_date_field('datetime-local', 'book_datetime_local')
        end
      end

      it "should not find date field" do
        expect(rendered).to have_form("/books", :post) do
          without_date_field(:date, 'book_something')
          without_date_field(:month, 'book_month', :with => { :value => 100500 })
        end
      end

      it "should raise exception if wrong date field type specified" do
        expect do
          expect(rendered).to have_form("/books", :post) do
            without_date_field(:unknown, 'book_something')
          end
        end.to raise_error('unknown type `unknown` for date picker')
        expect do
          expect(rendered).to have_form("/books", :post) do
            with_date_field(:unknown, 'book_something')
          end
        end.to raise_error('unknown type `unknown` for date picker')
      end
    end

    context "with_password_field" do
      it "should find password field" do
        expect(rendered).to have_form("/books", :post) do
          with_password_field('user[password]')
        end
      end

      it "should not find password field" do
        expect(rendered).to have_form("/books", :post) do
          without_password_field('account[password]')
        end
      end
    end

    context "with_file_field" do
      it "should find file field" do
        expect(rendered).to have_form("/books", :post) do
          with_file_field('form[file]')
        end
      end

      it "should not find file field" do
        expect(rendered).to have_form("/books", :post) do
          without_file_field('user[file]')
        end
      end
    end

    context "with_text_area" do
      it "should find text area" do
        expect(rendered).to have_form("/books", :post) do
          with_text_area('book[description]')
        end
      end

      it "should not find text area" do
        expect(rendered).to have_form("/books", :post) do
          without_text_area('user[bio]')
        end
      end
    end

    context "with_check_box" do
      it "should find check box" do
        expect(rendered).to have_form("/books", :post) do
          with_checkbox("book[still_in_print]")
          with_checkbox("book[still_in_print]","1")
        end
      end

      it "should not find check box" do
        expect(rendered).to have_form("/books", :post) do
          without_checkbox("book[book]")
          without_checkbox("book[still_in_print]","500")
        end
      end
    end

    context "with_radio_button" do
      it "should find radio button" do
        expect(rendered).to have_form("/books", :post) do
          with_radio_button("form[name]","true")
        end
      end

      it "should not find radio button" do
        expect(rendered).to have_form("/books", :post) do
          without_radio_button("form[name]","100500")
          without_radio_button("form[item]","false")
        end
      end
    end

    context "with_submit" do
      it "should find submit" do
        expect(rendered).to have_form("/books", :post) do
          with_submit("Create Book")
        end
      end

      it "should not find submit" do
        expect(rendered).to have_form("/books", :post) do
          without_submit("Destroy Book")
        end
      end
    end
  end
end
