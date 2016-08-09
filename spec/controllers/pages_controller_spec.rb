describe PagesController do
	describe "print_contributors" do
		it "returns empty result for empty array" do
			expect(controller.print_contributors([])).to eq('')
		end
		it "returns empty result for malformed array" do
			expect(controller.print_contributors(['test'])).to eq('')
			expect(controller.print_contributors([['test']])).to eq('')
		end
		it "returns correct result for one link" do
			expect(controller.print_contributors([['test', 'http://if-me.org']])).to eq('<a href="http://if-me.org">test</a>')
		end
		it "returns correct result for two links" do
			expect(controller.print_contributors([['test1', 'http://if-me.org'], ['test2', 'http://if-me.org']])).to eq('<a href="http://if-me.org">test1</a>, <a href="http://if-me.org">test2</a>')
		end
	end

	describe "print_partners" do
		it "returns empty result for empty array" do
			expect(controller.print_partners([])).to eq('')
		end
		it "returns empty result for malformed array" do
			expect(controller.print_partners(['test'])).to eq('')
			expect(controller.print_partners([['test']])).to eq('')
			expect(controller.print_partners([['test', 'http://if-me.org']])).to eq('')
		end
		it "returns correct result for one link" do
			expect(controller.print_partners([['test', 'http://if-me.org', 'test.png']])).to eq('<div class="partner"><a target="blank" href="http://if-me.org"><img alt="test" src="/images/test.png" /></a></div>')
		end
		it "returns correct result for two links" do
			expect(controller.print_partners([['test1', 'http://if-me.org', 'test1.png'], ['test2', 'http://if-me.org', 'test1.png']])).to eq('<div class="partner"><a target="blank" href="http://if-me.org"><img alt="test1" src="/images/test1.png" /></a></div><div class="spacer"></div><div class="partner"><a target="blank" href="http://if-me.org"><img alt="test2" src="/images/test1.png" /></a></div>')
		end
	end
end
