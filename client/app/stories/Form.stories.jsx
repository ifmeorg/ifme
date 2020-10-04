import React from 'react';
import { Form } from 'components/Form';
import { InputMocks } from 'mocks/InputMocks';

export default {
  title: 'Components/Form',
  parameters: {
    backgrounds: { default: 'mulberry' },
  },
};

export const Default = () => (
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
);
