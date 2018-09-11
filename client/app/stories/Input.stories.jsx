import React from 'react';
import { storiesOf } from '@storybook/react';
import { Input } from '../components/Input';

const someEvent = () => {
  window.alert('Event triggered!');
};

const checkboxes = [
  {
    id: 'some-id',
    name: 'some-name',
    label: 'Some checkbox',
    value: 1,
    checked: true,
    uncheckedValue: 0,
  },
  {
    id: 'some-other-id',
    name: 'some-other-name',
    label: 'Some other checkbox',
    value: 2,
    checked: true,
    uncheckedValue: 3,
  },
];

storiesOf('Input', module)
  .add('Text', () => (
    <div>
      <Input
        id="some-id"
        type="text"
        name="some-name"
        label="Hello"
        placeholder="Placeholder"
        required
        info="Some info here"
      />
      <Input
        id="some-id"
        type="text"
        name="some-name"
        label="Hello"
        placeholder="Placeholder"
        required
        info="Some info here"
        large
      />
      <Input
        id="some-id"
        type="text"
        name="some-name"
        label="Hello"
        placeholder="Placeholder"
        required
        info="Some info here"
        dark
      />
      <Input
        id="some-id"
        type="text"
        name="some-name"
        label="Hello"
        placeholder="Placeholder"
        required
        info="Some info here"
        dark
        large
      />
    </div>
  ))
  .add('Textarea', () => (
    <div>
      <Input
        id="some-id"
        type="textarea"
        name="some-name"
        label="Hello"
        placeholder="Placeholder"
        required
        info="Some info here"
      />
      <Input
        id="some-id"
        type="textarea"
        name="some-name"
        label="Hello"
        placeholder="Placeholder"
        required
        info="Some info here"
        large
      />
      <Input
        id="some-id"
        type="textarea"
        name="some-name"
        label="Hello"
        placeholder="Placeholder"
        required
        info="Some info here"
        dark
      />
      <Input
        id="some-id"
        type="textarea"
        name="some-name"
        label="Hello"
        placeholder="Placeholder"
        required
        info="Some info here"
        dark
        large
      />
    </div>
  ))
  .add('Submit', () => (
    <div>
      <Input
        id="some-id"
        type="submit"
        name="some-name"
        label="Hello"
        onClick={someEvent}
      />
      <Input
        id="some-id"
        type="submit"
        name="some-name"
        label="Hello"
        large
        onClick={someEvent}
      />
      <Input
        id="some-id"
        type="submit"
        name="some-name"
        label="Hello"
        dark
        onClick={someEvent}
      />
      <Input
        id="some-id"
        type="submit"
        name="some-name"
        label="Hello"
        large
        dark
        onClick={someEvent}
      />
    </div>
  ))
  .add('Checkbox', () => (
    <div>
      <Input
        id="some-id"
        type="checkbox"
        name="some-name"
        label="Some checkbox"
        value={1}
        checked
        uncheckedValue={0}
        onClick={someEvent}
      />
      <Input
        id="some-id"
        type="checkbox"
        name="some-name"
        label="Some checkbox"
        value={1}
        checked
        uncheckedValue={0}
        large
        onClick={someEvent}
      />
      <Input
        id="some-id"
        type="checkbox"
        name="some-name"
        label="Some checkbox"
        value={1}
        checked
        uncheckedValue={0}
        dark
        onClick={someEvent}
      />
      <Input
        id="some-id"
        type="checkbox"
        name="some-name"
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
        id="some-id"
        type="checkboxGroup"
        name="some-name"
        label="Some cool select label"
        info="Some info here"
        required
        checkboxes={checkboxes}
      />
      <Input
        id="some-id"
        type="checkboxGroup"
        name="some-name"
        label="Some cool select label"
        info="Some info here"
        required
        checkboxes={checkboxes}
        large
      />
      <Input
        id="some-id"
        type="checkboxGroup"
        name="some-name"
        label="Some cool select label"
        info="Some info here"
        required
        checkboxes={checkboxes}
        dark
      />
      <Input
        id="some-id"
        type="checkboxGroup"
        name="some-name"
        label="Some cool select label"
        info="Some info here"
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
        id="some-id"
        type="select"
        name="some-name"
        label="Some cool select label"
        value={2}
        options={[{ value: 1, label: 'First' }, { value: 2, label: 'Second' }]}
        onChange={someEvent}
      />
      <Input
        id="some-id"
        type="select"
        name="some-name"
        label="Some cool select label"
        value={2}
        options={[{ value: 1, label: 'First' }, { value: 2, label: 'Second' }]}
        onChange={someEvent}
        large
      />
      <Input
        id="some-id"
        type="select"
        name="some-name"
        label="Some cool select label"
        value={2}
        options={[{ value: 1, label: 'First' }, { value: 2, label: 'Second' }]}
        onChange={someEvent}
        dark
      />
      <Input
        id="some-id"
        type="select"
        name="some-name"
        label="Some cool select label"
        value={2}
        options={[{ value: 1, label: 'First' }, { value: 2, label: 'Second' }]}
        onChange={someEvent}
        dark
        large
      />
    </div>
  ));
