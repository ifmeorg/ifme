import React from 'react';
import { InputMocks } from '../mocks/InputMocks';
import { grey } from '../../.storybook/backgrounds';

export default {
  title: 'Components/Input',
  parameters: {
    backgrounds: [{ ...grey, default: true }],
  },
};

export const Text = () => (
  <>
    {InputMocks.createInput(InputMocks.inputTextProps, {
      required: true,
      small: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextProps, {
      required: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextProps, {
      required: true,
      large: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextProps, {
      required: true,
      dark: true,
      small: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextProps, {
      required: true,
      dark: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextProps, {
      required: true,
      dark: true,
      large: true,
    })}
  </>
);

export const TextWithAccordion = () => (
  <>
    {InputMocks.createInput(InputMocks.inputTextProps, {
      required: true,
      small: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextProps, {
      required: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextProps, {
      required: true,
      large: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextProps, {
      required: true,
      dark: true,
      small: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextProps, {
      required: true,
      dark: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextProps, {
      required: true,
      dark: true,
      large: true,
      accordion: true,
    })}
  </>
);

TextWithAccordion.story = {
  name: 'Text with accordion',
};

export const Textarea = () => (
  <>
    {InputMocks.createInput(InputMocks.inputTextareaProps, {
      required: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextareaProps, {
      required: true,
      large: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextareaProps, {
      required: true,
      dark: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextareaProps, {
      required: true,
      dark: true,
      large: true,
    })}
  </>
);

export const TextareaWithAccordion = () => (
  <>
    {InputMocks.createInput(InputMocks.inputTextareaProps, {
      required: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextareaProps, {
      required: true,
      large: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextareaProps, {
      required: true,
      dark: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextareaProps, {
      required: true,
      dark: true,
      large: true,
      accordion: true,
    })}
  </>
);

TextareaWithAccordion.story = {
  name: 'Textarea with accordion',
};

export const Submit = () => (
  <>
    {InputMocks.createInput(InputMocks.inputSubmitProps, {
      onClick: InputMocks.event,
      small: true,
    })}
    {InputMocks.createInput(InputMocks.inputSubmitProps, {
      onClick: InputMocks.event,
    })}
    {InputMocks.createInput(InputMocks.inputSubmitProps, {
      onClick: InputMocks.event,
      large: true,
    })}
    {InputMocks.createInput(InputMocks.inputSubmitProps, {
      onClick: InputMocks.event,
      dark: true,
      small: true,
    })}
    {InputMocks.createInput(InputMocks.inputSubmitProps, {
      onClick: InputMocks.event,
      dark: true,
    })}
    {InputMocks.createInput(InputMocks.inputSubmitProps, {
      onClick: InputMocks.event,
      dark: true,
      large: true,
    })}
  </>
);

export const Checkbox = () => (
  <>
    {InputMocks.createInput(InputMocks.inputCheckboxProps, {
      onChange: InputMocks.event,
    })}
    {InputMocks.createInput(InputMocks.inputCheckboxProps, {
      onChange: InputMocks.event,
      large: true,
    })}
    {InputMocks.createInput(InputMocks.inputCheckboxProps, {
      onChange: InputMocks.event,
      dark: true,
    })}
    {InputMocks.createInput(InputMocks.inputCheckboxProps, {
      onChange: InputMocks.event,
      dark: true,
      large: true,
    })}
  </>
);

export const CheckboxGroup = () => (
  <>
    {InputMocks.createInput(InputMocks.inputCheckboxGroupProps, {
      required: true,
    })}
    {InputMocks.createInput(InputMocks.inputCheckboxGroupProps, {
      required: true,
      large: true,
    })}
    {InputMocks.createInput(InputMocks.inputCheckboxGroupProps, {
      required: true,
      dark: true,
    })}
    {InputMocks.createInput(InputMocks.inputCheckboxGroupProps, {
      required: true,
      dark: true,
      large: true,
    })}
  </>
);

CheckboxGroup.story = {
  name: 'CheckboxGroup',
};

export const CheckboxGroupWithAccordion = () => (
  <>
    {InputMocks.createInput(InputMocks.inputCheckboxGroupProps, {
      required: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputCheckboxGroupProps, {
      required: true,
      large: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputCheckboxGroupProps, {
      required: true,
      dark: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputCheckboxGroupProps, {
      required: true,
      dark: true,
      large: true,
      accordion: true,
    })}
  </>
);

CheckboxGroupWithAccordion.story = {
  name: 'CheckboxGroup with accordion',
};

export const Select = () => (
  <>
    {InputMocks.createInput(InputMocks.inputSelectProps, {
      onChange: InputMocks.event,
      small: true,
    })}
    {InputMocks.createInput(InputMocks.inputSelectProps, {
      onChange: InputMocks.event,
    })}
    {InputMocks.createInput(InputMocks.inputSelectProps, {
      onChange: InputMocks.event,
      large: true,
    })}
    {InputMocks.createInput(InputMocks.inputSelectProps, {
      onChange: InputMocks.event,
      dark: true,
      small: true,
    })}
    {InputMocks.createInput(InputMocks.inputSelectProps, {
      onChange: InputMocks.event,
      dark: true,
    })}
    {InputMocks.createInput(InputMocks.inputSelectProps, {
      onChange: InputMocks.event,
      dark: true,
      large: true,
    })}
  </>
);

export const SelectWithAccordion = () => (
  <>
    {InputMocks.createInput(InputMocks.inputSelectProps, {
      onChange: InputMocks.event,
      accordion: true,
      small: true,
    })}
    {InputMocks.createInput(InputMocks.inputSelectProps, {
      onChange: InputMocks.event,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputSelectProps, {
      onChange: InputMocks.event,
      large: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputSelectProps, {
      onChange: InputMocks.event,
      dark: true,
      accordion: true,
      small: true,
    })}
    {InputMocks.createInput(InputMocks.inputSelectProps, {
      onChange: InputMocks.event,
      dark: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputSelectProps, {
      onChange: InputMocks.event,
      dark: true,
      large: true,
      accordion: true,
    })}
  </>
);

SelectWithAccordion.story = {
  name: 'Select with accordion',
};

export const Tag = () => (
  <>
    {InputMocks.createInput(InputMocks.inputTagProps, { small: true })}
    {InputMocks.createInput(InputMocks.inputTagProps)}
    {InputMocks.createInput(InputMocks.inputTagProps, {
      large: true,
    })}
    {InputMocks.createInput(InputMocks.inputTagProps, {
      dark: true,
      small: true,
    })}
    {InputMocks.createInput(InputMocks.inputTagProps, {
      dark: true,
    })}
    {InputMocks.createInput(InputMocks.inputTagProps, {
      dark: true,
      large: true,
    })}
  </>
);

export const TagWithAccordion = () => (
  <>
    {InputMocks.createInput(InputMocks.inputTagProps, {
      small: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputTagProps, { accordion: true })}
    {InputMocks.createInput(InputMocks.inputTagProps, {
      large: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputTagProps, {
      dark: true,
      accordion: true,
      small: true,
    })}
    {InputMocks.createInput(InputMocks.inputTagProps, {
      dark: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputTagProps, {
      dark: true,
      large: true,
      accordion: true,
    })}
  </>
);

TagWithAccordion.story = {
  name: 'Tag with accordion',
};

export const Switch = () => (
  <>
    {InputMocks.createInput(InputMocks.inputSwitchProps)}
    {InputMocks.createInput(InputMocks.inputSwitchProps, {
      large: true,
    })}
    {InputMocks.createInput(InputMocks.inputSwitchProps, {
      dark: true,
    })}
    {InputMocks.createInput(InputMocks.inputSwitchProps, {
      dark: true,
      large: true,
    })}
  </>
);

export const SwitchWithAccordion = () => (
  <>
    {InputMocks.createInput(InputMocks.inputSwitchProps, { accordion: true })}
    {InputMocks.createInput(InputMocks.inputSwitchProps, {
      large: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputSwitchProps, {
      dark: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputSwitchProps, {
      dark: true,
      large: true,
      accordion: true,
    })}
  </>
);

SwitchWithAccordion.story = {
  name: 'Switch with accordion',
};

export const Password = () => (
  <>
    {InputMocks.createInput(InputMocks.inputPasswordProps)}
    {InputMocks.createInput(InputMocks.inputPasswordProps, {
      large: true,
    })}
    {InputMocks.createInput(InputMocks.inputPasswordProps, {
      dark: true,
    })}
    {InputMocks.createInput(InputMocks.inputPasswordProps, {
      dark: true,
      large: true,
    })}
  </>
);

export const PasswordWithAccordion = () => (
  <>
    {InputMocks.createInput(InputMocks.inputPasswordProps, {
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputPasswordProps, {
      large: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputPasswordProps, {
      dark: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputPasswordProps, {
      dark: true,
      large: true,
      accordion: true,
    })}
  </>
);

PasswordWithAccordion.story = {
  name: 'Password with accordion',
};
