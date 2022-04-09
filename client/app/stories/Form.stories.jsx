/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { Form } from 'components/Form';
import { InputMocks } from 'mocks/InputMocks';

export default {
  title: 'Components/Form',
  component: Form,
};

const Template = (args) => <Form {...args} />;

export const Default = Template.bind({});

Default.args = {
  action: '/post-wont-work',
  inputs: [
    { ...InputMocks.inputTextProps, required: true, dark: true },
    {
      ...InputMocks.inputTextareaProps,
      required: true,
      accordion: true,
      dark: true,
    },
    { ...InputMocks.inputSelectProps, dark: true },
    { ...InputMocks.inputCheckboxGroupProps, required: true, dark: true },
    { ...InputMocks.inputTagProps, dark: true },
    { ...InputMocks.inputSwitchProps, dark: true },
    { ...InputMocks.inputSubmitProps, dark: true },
  ],
};
