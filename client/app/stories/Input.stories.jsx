import React from 'react';
import { storiesOf } from '@storybook/react';
import { Input } from '../components/Input';

const someEvent = () => {
  window.alert('Event triggered!');
};
const options = [{ value: 1, label: 'First' }, { value: 2, label: 'Second' }];
const id = 'some-id';
const name = 'some-name';
const label = 'Some Label';
const value = 'Some Value';
const placeholder = 'Some Placeholder';
const info = 'Some Info';
const idTwo = 'some-other-id';
const nameTwo = 'some-other-name';
const labelTwo = 'Some Other Label';
const checkboxes = [
  {
    id,
    name,
    label,
    value: 1,
    checked: true,
    uncheckedValue: 0,
  },
  {
    id: idTwo,
    name: nameTwo,
    label: labelTwo,
    value: 2,
  },
];

storiesOf('Input', module)
  .add('Text', () => (
    <div>
      <Input
        id={id}
        type="text"
        name={name}
        label={label}
        placeholder={placeholder}
        required
        info={info}
      />
      <Input
        id={id}
        type="text"
        name={name}
        label={label}
        placeholder={placeholder}
        required
        info={info}
        large
      />
      <Input
        id={id}
        type="text"
        name={name}
        label={label}
        placeholder={placeholder}
        required
        info={info}
        dark
      />
      <Input
        id={id}
        type="text"
        name={name}
        label={label}
        placeholder={placeholder}
        required
        info={info}
        dark
        large
      />
    </div>
  ))
  .add('Textarea', () => (
    <div>
      <Input
        id={id}
        type="textarea"
        name={name}
        label={label}
        placeholder={placeholder}
        required
        info={info}
      />
      <Input
        id={id}
        type="textarea"
        name={name}
        label={label}
        placeholder={placeholder}
        required
        info={info}
        large
      />
      <Input
        id={id}
        type="textarea"
        name={name}
        label={label}
        placeholder={placeholder}
        required
        info={info}
        dark
      />
      <Input
        id={id}
        type="textarea"
        name={name}
        label={label}
        placeholder={placeholder}
        required
        info={info}
        dark
        large
      />
    </div>
  ))
  .add('Submit', () => (
    <div>
      <Input
        id={id}
        type="submit"
        name={name}
        value={value}
        onClick={someEvent}
      />
      <Input
        id={id}
        type="submit"
        name={name}
        value={value}
        large
        onClick={someEvent}
      />
      <Input
        id={id}
        type="submit"
        name={name}
        value={value}
        dark
        onClick={someEvent}
      />
      <Input
        id={id}
        type="submit"
        name={name}
        value={value}
        large
        dark
        onClick={someEvent}
      />
    </div>
  ))
  .add('Checkbox', () => (
    <div>
      <Input
        id={id}
        type="checkbox"
        name={name}
        label="Some checkbox"
        value={1}
        checked
        uncheckedValue={0}
        onClick={someEvent}
      />
      <Input
        id={id}
        type="checkbox"
        name={name}
        label="Some checkbox"
        value={1}
        checked
        uncheckedValue={0}
        large
        onClick={someEvent}
      />
      <Input
        id={id}
        type="checkbox"
        name={name}
        label="Some checkbox"
        value={1}
        checked
        uncheckedValue={0}
        dark
        onClick={someEvent}
      />
      <Input
        id={id}
        type="checkbox"
        name={name}
        label="Some checkbox"
        value={1}
        checked
        uncheckedValue={0}
        dark
        large
        onClick={someEvent}
      />
    </div>
  ))
  .add('CheckboxGroup', () => (
    <div>
      <Input
        id={id}
        type="checkboxGroup"
        name={name}
        label={label}
        info={info}
        required
        checkboxes={checkboxes}
      />
      <Input
        id={id}
        type="checkboxGroup"
        name={name}
        label={label}
        info={info}
        required
        checkboxes={checkboxes}
        large
      />
      <Input
        id={id}
        type="checkboxGroup"
        name={name}
        label={label}
        info={info}
        required
        checkboxes={checkboxes}
        dark
      />
      <Input
        id={id}
        type="checkboxGroup"
        name={name}
        label={label}
        info={info}
        required
        checkboxes={checkboxes}
        dark
        large
      />
    </div>
  ))
  .add('Select', () => (
    <div>
      <Input
        id={id}
        type="select"
        name={name}
        label={label}
        value={2}
        options={options}
        onChange={someEvent}
      />
      <Input
        id={id}
        type="select"
        name={name}
        label={label}
        value={2}
        options={options}
        onChange={someEvent}
        large
      />
      <Input
        id={id}
        type="select"
        name={name}
        label={label}
        value={2}
        options={options}
        onChange={someEvent}
        dark
      />
      <Input
        id={id}
        type="select"
        name={name}
        label={label}
        value={2}
        options={options}
        onChange={someEvent}
        dark
        large
      />
    </div>
  ));
