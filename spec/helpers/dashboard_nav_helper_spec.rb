describe DashboardNavHelper do
  describe '#dashboard_nav_link_to' do
    let(:active)    { true }
    let(:label)     { 'foo' }
    let(:path)      { 'bar' }
    let(:options)   { {} }

    subject { dashboard_nav_link_to(label, path, options) }

    before(:each) do
      allow(self).to receive('active?').and_return(active)
    end

    context 'when active' do
      let(:active) { true }
      it { is_expected.to have_selector 'a' }
      it { is_expected.to include label }
      it { is_expected.to have_selector 'a.dashboardNavLinksActive' }
    end

    context 'when not active' do
      let(:active) { false }
      it { is_expected.to have_selector 'a' }
      it { is_expected.to include label }
      it { is_expected.not_to have_selector 'a.dashboardNavLinksActive' }
    end

    context 'when options include method' do
      let(:options) { { :method => :delete } }

      it 'passes method in environment' do
        expect(self).to receive(:active?).with(path, options)
        dashboard_nav_link_to(label, path, options)
      end
    end
  end
end
