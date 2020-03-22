import React from 'react';
import { storiesOf } from '@storybook/react';
import { InputMocks } from '../mocks/InputMocks';

storiesOf('Input', module)
  .add('Text', () => (
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
  ))
  .add('Text with accordion', () => (
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
  ))
  .add('Textarea', () => (
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
  ))
  .add('Textarea with accordion', () => (
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
  ))
  .add('Submit', () => (
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
  ))
  .add('Checkbox', () => (
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
  ))
  .add('CheckboxGroup', () => (
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
  ))
  .add('CheckboxGroup with accordion', () => (
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
  ))
  .add('Select', () => (
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
  ))
  .add('Select with accordion', () => (
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
  ))
  .add('Tag', () => (
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
  ))
  .add('Tag with accordion', () => (
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
  ))
  .add('Switch', () => (
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
  ))
  .add('Switch with accordion', () => (
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
  ))
  .add('Password', () => (
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
  ))
  .add('Password with accordion', () => (
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
  ));
