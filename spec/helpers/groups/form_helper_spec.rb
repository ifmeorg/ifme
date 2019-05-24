describe GroupsFormHelper do
  let(:inputs) { nil }
  let(:action) { nil }
  let(:valid_inputs) do
    [
      {
        id: '1',
        type: 'text',
        name: 'group1',
        label: t('common.name'),
        value: 'Hello',
        required: true,
        dark: true
      },
      {
        type: 'textarea',
        name: 'First Description',
        label: t('common.form.description'),
        value: 'Hi again',
        required: true,
        dark: true
      }
    ]
  end

  let(:valid_action) { '/groups' }
  
  describe '#new_group_props' do
    subject { new_group_props(inputs, action) }

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
              id: '1',
              type: 'text',
              name: 'group1',
              label: t('common.name'),
              value: 'Hello',
              required: true,
              dark: true
            },
            {
              type: 'textarea',
              name: 'First Description',
              label: t('common.form.description'),
              value: 'Hi again',
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
      subject { edit_group_props(inputs, action) }
  
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
                id: '2',
                type: 'text',
                name: 'Edited Group',
                label: t('common.name'),
                value: 'I ame edited',
                required: true,
                dark: true
              },
              {
                type: 'textarea',
                name: 'Edited Description',
                label: t('common.form.description'),
                value: 'I am an edited description',
                required: true,
                dark: true
              },
              { id: '_method', name: '_method', type: 'hidden', value: 'patch' },
              { id: 'submit', type: 'submit', value: 'Submit', dark: true }
            ],
            action: '/groups'
          )
        end
      end
    end
  end
end