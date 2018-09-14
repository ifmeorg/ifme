import React from 'react';
import { storiesOf } from '@storybook/react';
import { Form } from '../components/Form';

storiesOf('Form', module).add('Form', () => (
  <Form
    inputs={[
      {
        id: 'some-text-id',
        type: 'text',
        name: 'some-text-name',
        label: 'Some Text Label',
        required: true,
      },
      {
        id: 'some-textarea-id',
        type: 'textarea',
        name: 'some-textarea-name',
        label: 'Some Textarea Label',
        placeholder: 'Some Textarea Placeholder',
        required: true,
        accordion: true,
      },
      {
        id: 'some-select-id',
        type: 'select',
        name: 'some-select-name',
        label: 'Some Select Label',
        value: 2,
        options: [{ value: 1, label: 'First' }, { value: 2, label: 'Second' }],
      },
      {
        id: 'some-checkbox-group-id',
        type: 'checkboxGroup',
        name: 'some-checkbox-group-name',
        label: 'Some Checkbox Group Label',
        required: true,
        checkboxes: [
          {
            id: 'some-checkbox-one',
            name: 'some-checkbox-one-name',
            label: 'Some Checkbox One Label',
            value: 1,
            checked: true,
            uncheckedValue: 0,
          },
          {
            id: 'some-checkbox-two',
            name: 'some-checkbox-two-name',
            label: 'Some Checkbox Two Label',
            value: 2,
          },
        ],
      },
      {
        id: 'some-submit-id',
        type: 'submit',
        name: 'some-submit-name',
        value: 'Some Submit Value',
      },
    ]}
  />
));
