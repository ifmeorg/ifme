// @flow
import React from 'react';
import type { Checkbox } from './utils';
import { InputCheckbox } from './InputCheckbox';

export type Props = {
  checkboxes: Checkbox[],
  required?: boolean, // At least one checkbox must be checked
  hasError?: Function,
};

export type State = {
  checkboxes: Checkbox[],
};

export class InputCheckboxGroup extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { checkboxes: props.checkboxes };
  }

  handleOnChange = (checkbox: { checked: boolean, id: string }) => {
    const { hasError, required } = this.props;
    const { checkboxes } = this.state;
    const newCheckboxes = checkboxes.map((item: Checkbox) => {
      const newItem = Object.assign({}, item);
      if (newItem.id === checkbox.id) {
        newItem.checked = checkbox.checked;
      }
      return newItem;
    });
    if (required && hasError) {
      hasError(newCheckboxes.filter(item => item.checked).length === 0);
    }
    this.setState({ checkboxes: newCheckboxes });
  };

  render() {
    const { checkboxes } = this.state;
    return (
      <div>
        {checkboxes.map((checkbox: Checkbox) => (
          <InputCheckbox
            id={checkbox.id}
            name={checkbox.name}
            key={checkbox.id}
            value={checkbox.value}
            checked={checkbox.checked}
            uncheckedValue={checkbox.uncheckedValue}
            label={checkbox.label}
            onChange={this.handleOnChange}
          />
        ))}
      </div>
    );
  }
}
