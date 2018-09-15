import React from 'react';
import { storiesOf } from '@storybook/react';
import { InputMocks } from '../mocks/InputMocks';

storiesOf('Input', module)
  .add('Text', () => (
    <div>
      {InputMocks.createInput(InputMocks.inputTextProps, {
        required: true,
        large: true,
      })}
      {InputMocks.createInput(InputMocks.inputTextProps, {
        required: true,
        large: true,
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
    </div>
  ))
  .add('Text with accordion', () => (
    <div>
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
        accordion: true,
      })}
      {InputMocks.createInput(InputMocks.inputTextProps, {
        required: true,
        dark: true,
        large: true,
        accordion: true,
      })}
    </div>
  ))
  .add('Textarea', () => (
    <div>
      {InputMocks.createInput(InputMocks.inputTextareaProps, {
        required: true,
        large: true,
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
    </div>
  ))
  .add('Textarea with accordion', () => (
    <div>
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
    </div>
  ))
  .add('Submit', () => (
    <div>
      {InputMocks.createInput(InputMocks.inputSubmitProps, {
        onClick: InputMocks.event,
        large: true,
      })}
      {InputMocks.createInput(InputMocks.inputSubmitProps, {
        onClick: InputMocks.event,
        large: true,
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
    </div>
  ))
  .add('Checkbox', () => (
    <div>
      {InputMocks.createInput(InputMocks.inputCheckboxProps, {
        onChange: InputMocks.event,
        large: true,
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
    </div>
  ))
  .add('CheckboxGroup', () => (
    <div>
      {InputMocks.createInput(InputMocks.inputCheckboxGroupProps, {
        required: true,
        large: true,
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
    </div>
  ))
  .add('CheckboxGroup with accordion', () => (
    <div>
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
    </div>
  ))
  .add('Select', () => (
    <div>
      {InputMocks.createInput(InputMocks.inputSelectProps, {
        onChange: InputMocks.event,
        large: true,
      })}
      {InputMocks.createInput(InputMocks.inputSelectProps, {
        onChange: InputMocks.event,
        large: true,
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
    </div>
  ))
  .add('Select with accordion', () => (
    <div>
      {InputMocks.createInput(InputMocks.inputSelectProps, {
        onChange: InputMocks.event,
        large: true,
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
      })}
      {InputMocks.createInput(InputMocks.inputSelectProps, {
        onChange: InputMocks.event,
        dark: true,
        large: true,
        accordion: true,
      })}
    </div>
  ))
  .add('Tag', () => (
    <div>
      {InputMocks.createInput(InputMocks.inputTagProps)}
      {InputMocks.createInput(InputMocks.inputTagProps, {
        large: true,
      })}
      {InputMocks.createInput(InputMocks.inputTagProps, {
        dark: true,
      })}
      {InputMocks.createInput(InputMocks.inputTagProps, {
        dark: true,
        large: true,
      })}
    </div>
  ))
  .add('Tag with accordion', () => (
    <div>
      {InputMocks.createInput(InputMocks.inputTagProps, { accordion: true })}
      {InputMocks.createInput(InputMocks.inputTagProps, {
        large: true,
        accordion: true,
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
    </div>
  ));
