import React from 'react';
import { storiesOf } from '@storybook/react';
import { Form } from '../components/Form';
import { InputMocks } from '../mocks/InputMocks';

storiesOf('Form', module).add('Form', () => (
  <Form
    action="/post-wont-work"
    inputs={[
      Object.assign({}, InputMocks.inputTextProps, { required: true }),
      Object.assign({}, InputMocks.inputTextareaProps, {
        required: true,
        accordion: true,
      }),
      InputMocks.inputSelectProps,
      Object.assign({}, InputMocks.inputCheckboxGroupProps, { required: true }),
      InputMocks.inputTagProps,
      InputMocks.inputSwitchProps,
      InputMocks.inputSubmitProps,
    ]}
  />
));
