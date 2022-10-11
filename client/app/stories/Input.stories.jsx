/* eslint-disable no-unused-vars */
/* eslint-disable max-len */
import React from 'react';
import { InputMocks } from 'mocks/InputMocks';

export default {
  title: 'Components/Input',
};

const InputTextTemplate = (args) => (
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

export const InputText = InputTextTemplate.bind({});

InputText.storyName = 'InputText';

const InputTextWithAccordionTemplate = (args) => (
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

export const InputTextWithAccordion = InputTextWithAccordionTemplate.bind({});

InputTextWithAccordion.storyName = 'InputText with accordion';

const MyInputTextareaTemplate = (args) => (
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

export const InputTextarea = MyInputTextareaTemplate.bind({});

InputTextarea.storyName = 'InputTextarea';

const InputTextareaWithAccordionTemplate = (args) => (
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

export const InputTextareaWithAccordion = InputTextareaWithAccordionTemplate.bind({});

InputTextareaWithAccordion.storyName = 'InputTextarea with accordion';

const InputTextareaTemplateTemplate = (args) => (
  <>
    {InputMocks.createInput(InputMocks.inputTextareaTemplateProps, {
      required: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextareaTemplateProps, {
      required: true,
      large: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextareaTemplateProps, {
      required: true,
      dark: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextareaTemplateProps, {
      required: true,
      dark: true,
      large: true,
    })}
  </>
);

export const InputTextareaTemplate = InputTextareaTemplateTemplate.bind({});

InputTextareaTemplate.storyName = 'InputTextareaTemplate';

const InputTextareaTemplateWithAccordionTemplate = (args) => (
  <>
    {InputMocks.createInput(InputMocks.inputTextareaTemplateProps, {
      required: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextareaTemplateProps, {
      required: true,
      large: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextareaTemplateProps, {
      required: true,
      dark: true,
      accordion: true,
    })}
    {InputMocks.createInput(InputMocks.inputTextareaTemplateProps, {
      required: true,
      dark: true,
      large: true,
      accordion: true,
    })}
  </>
);

export const InputTextareaTemplateWithAccordion = InputTextareaTemplateWithAccordionTemplate.bind({});

InputTextareaTemplateWithAccordion.storyName = 'InputTextareaTemplate with accordion';

const SubmitTemplate = (args) => (
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

export const Submit = SubmitTemplate.bind({});

const CheckboxTemplate = (args) => (
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

export const Checkbox = CheckboxTemplate.bind({});

const CheckboxGroupTemplate = (args) => (
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

export const CheckboxGroup = CheckboxTemplate.bind({});

CheckboxGroup.storyName = 'CheckboxGroup';

const CheckboxGroupWithAccordionTemplate = (args) => (
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

export const CheckboxGroupWithAccordion = CheckboxGroupWithAccordionTemplate.bind({});

CheckboxGroupWithAccordion.storyName = 'CheckboxGroup with accordion';

const SelectTemplate = (args) => (
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

export const Select = SelectTemplate.bind({});

const SelectWithAccordionTemplate = (args) => (
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

export const SelectWithAccordion = SelectWithAccordionTemplate.bind({});

SelectWithAccordion.storyName = 'Select with accordion';

const TagTemplate = (args) => (
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

export const Tag = TagTemplate.bind({});

const TagWithAccordionTemplate = (args) => (
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

export const TagWithAccordion = TagWithAccordionTemplate.bind({});

TagWithAccordion.storyName = 'Tag with accordion';

const SwitchTemplate = (args) => (
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

export const Switch = SwitchTemplate.bind({});

const SwitchWithAccordionTemplate = (args) => (
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

export const SwitchWithAccordion = SwitchWithAccordionTemplate.bind({});
SwitchWithAccordion.storyName = 'Switch with accordion';

const PasswordTemplate = (args) => (
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

export const Password = PasswordTemplate.bind({});

const PasswordWithAccordionTemplate = (args) => (
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

export const PasswordWithAccordion = PasswordWithAccordionTemplate.bind({});
PasswordWithAccordion.storyName = 'Password with accordion';
