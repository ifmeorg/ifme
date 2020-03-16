import React from 'react';
import { storiesOf } from '@storybook/react';
import Form from '../components/Form';
import { InputMocks } from '../mocks/InputMocks';

storiesOf('Form', module).add('Form', () => (
  <Form
    action="/post-wont-work"
    inputs={[
      { ...InputMocks.inputTextProps, required: true },
      {
        ...InputMocks.inputTextareaProps,
        required: true,
        accordion: true,
      },
      InputMocks.inputSelectProps,
      { ...InputMocks.inputCheckboxGroupProps, required: true },
      InputMocks.inputTagProps,
      InputMocks.inputSwitchProps,
      InputMocks.inputSubmitProps,
    ]}
  />
));
