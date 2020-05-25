import React from 'react';
import { Form } from '../components/Form';
import { InputMocks } from '../mocks/InputMocks';
import { mulberry } from '../../.storybook/backgrounds';

export default {
  title: 'Components/Form',
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
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
