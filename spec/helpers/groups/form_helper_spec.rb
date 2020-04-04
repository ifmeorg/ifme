describe GroupsFormHelper do
  let(:group) { create(:group) }

  before do
    @group = group
  end

  describe '#new_group_props' do
    subject { new_group_props }

    before do
      @group = nil
    end

    it 'returns correct props' do
      expect(subject).to eq(
        inputs: [
          {
            id: 'group_name',
            type: 'text',
            name: 'group[name]',
            label: t('common.name'),
            value: nil,
            required: true,
            dark: true
          },
          {
            id: 'group_description',
            type: 'textarea',
            name: 'group[description]',
            label: t('common.form.description'),
            value: nil,
            required: true,
            dark: true
          },
          { id: 'submit', type: 'submit', value: 'Submit', dark: true, name: 'commit' }
        ],
        action: '/groups'
      )
    end
  end

  describe '#edit_group_props' do
    subject { edit_group_props }

    before do
      params[:controller] = 'application'
      allow(controller).to receive(:action_name).and_return('edit')
    end

    it 'returns the correct props' do
      expect(subject).to eq(
        inputs: [
          {
            id: 'group_name',
            type: 'text',
            name: 'group[name]',
            label: t('common.name'),
            value: group.name,
            required: true,
            dark: true
          },
          {
            id: 'group_description',
            type: 'textarea',
            name: 'group[description]',
            label: t('common.form.description'),
            value: group.description,
            required: true,
            dark: true
          },
          {
            checkboxes: [],
            dark: true,
            id: 'group_leader',
            label: 'Leaders',
            name: 'group[leader]',
            required: true,
            type: 'checkboxGroup'
          },
          { id: '_method', name: '_method', type: 'hidden', value: 'patch' },
          { id: 'submit', type: 'submit', value: 'Submit', dark: true, name: 'commit' }
        ],
        action: '/groups/test-group'
      )
    end
  end
end