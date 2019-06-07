describe GroupsFormHelper do
  let(:group) { create(:group) }
  let(:inputs) { nil }
  let(:action) { nil }
  
  before do
    @group = group 
  end
  
  let(:valid_inputs) do
    [
      {
        id: 'group_name',
        type: 'text',
        name: 'group[name]',
        label: t('common.name'),
        value: 'Test Group',
        required: true,
        dark: true
      },
      {
        id: 'group_description',
        type: 'textarea',
        name: 'group[description]',
        label: t('common.form.description'),
        value: 'Group description',
        required: true,
        dark: true
      }
    ]
  end

  let(:valid_action) { '/groups' }
  
  describe '#new_group_props' do
    subject { new_group_props }

    context 'has invalid arguments' do
      it 'returns nil' do
        expect(subject).to eq(nil)
        
        #LEFT OFF HERE (FOLLOWED PATH OF TRACKING THE NEW VIEW FOR FORMS, THEN FORM IN HELPERS, THEN SPEC FOLDER)
        #COPIED VALID INPUTS TO TESTING INPUTS
      end
    end

    context 'has valid arguments' do
      let(:inputs) { valid_inputs }
      let(:action) { valid_action }
      it 'returns correct props' do
        expect(subject).to eq(
          inputs: [
            {
              id: 'group_name',
              type: 'text',
              name: 'group[name]',
              label: t('common.name'),
              value: 'Test Group',
              required: true,
              dark: true
            },
            {
              id: 'group_description',
              type: 'textarea',
              name: 'group[description]',
              label: t('common.form.description'),
              value: 'Group description',
              required: true,
              dark: true
            },
            { id: 'submit', type: 'submit', value: 'Submit', dark: true }
          ],
          action: '/groups'
        )
      end
    end

    describe '#edit_group_props' do
      subject { edit_group_props }
  
      context 'has invalid arguments' do
        it 'returns nil' do
          expect(subject).to eq(nil)
        end
      end
  
      context 'has valid arguments' do
        let(:inputs) { valid_inputs }
        let(:action) { valid_action }
        it 'returns correct props' do
          expect(subject).to eq(
            inputs: [
              {
                id: 'group_name',
                type: 'text',
                name: 'group[name]',
                label: t('common.name'),
                value: 'Test Group',
                required: true,
                dark: true
              },
              {
                id: 'group_description',
                type: 'textarea',
                name: 'group[description]',
                label: t('common.form.description'),
                value: 'Group description',
                required: true,
                dark: true
              },
              { id: '_method', name: '_method', type: 'hidden', value: 'patch' },
              { id: 'submit', type: 'submit', value: 'Submit', dark: true }
            ],
            action: '/groups/test-group'
          )
        end
      end
    end
  end
end