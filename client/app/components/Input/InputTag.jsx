// @flow
import React from 'react';
import Autocomplete from 'react-autocomplete';
import type { Checkbox } from './index';
import { InputCheckbox } from './InputCheckbox';
import inputCss from './Input.scss';
import css from './InputTag.scss';

export type Props = {
  id: string,
  name: string,
  placeholder?: string,
  checkboxes: Checkbox[],
};

export type State = {
  checkboxes: Checkbox[],
  autocompleteLabel?: string,
};

export class InputTag extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { checkboxes: props.checkboxes };
  }

  check = (id: string, checked: boolean) => {
    this.setState((prevState: State) => {
      let { checkboxes } = prevState;
      checkboxes = checkboxes.map((checkbox: Checkbox) => {
        const newCheckbox = Object.assign({}, checkbox);
        if (newCheckbox.id === id) {
          newCheckbox.checked = checked;
        }
        return newCheckbox;
      });
      return { checkboxes, autocompleteLabel: undefined };
    });
  };

  checkboxChange = (checkbox: { checked: boolean, id: string }) => {
    const { checked, id } = checkbox;
    const { checkboxes } = this.state;
    if (
      !checked
      && checkboxes.filter((item: Checkbox) => item.id === id && item.checked)
        .length
    ) {
      this.check(id, false);
    }
  };

  setAutocompleteLabel = (label: string) => {
    this.setState({ autocompleteLabel: label });
    if (label.length) {
      const { checkboxes } = this.state;
      const checkboxWithLabel = checkboxes.filter(
        checkbox => checkbox.label === label,
      );
      if (checkboxWithLabel.length && !checkboxWithLabel[0].checked) {
        this.check(checkboxWithLabel[0].id, true);
      }
    }
  };

  shouldItemRender = (checkbox: Checkbox, label: string) => {
    const checkboxLabel = checkbox.label.toLowerCase();
    return checkboxLabel.indexOf(label.toLowerCase()) > -1;
  };

  onChange = (e: SyntheticEvent<HTMLInputElement>) => {
    const { value } = e.currentTarget;
    this.setAutocompleteLabel(value);
  };

  onSelect = (label: string) => {
    this.setAutocompleteLabel(label);
  };

  getLabel = (checkbox: Checkbox) => checkbox.label;

  displayCheckbox = (checkbox: Checkbox) => {
    const { name } = this.props;
    if (!checkbox.checked) return null;
    return (
      <InputCheckbox
        id={checkbox.id}
        name={name}
        key={checkbox.id}
        value={checkbox.value}
        label={checkbox.label}
        onChange={this.checkboxChange}
        checked
      />
    );
  };

  displayAutocomplete = () => {
    const { placeholder } = this.props;
    const { autocompleteLabel, checkboxes } = this.state;
    return (
      <Autocomplete
        getItemValue={this.getLabel}
        items={checkboxes}
        renderItem={this.renderItem}
        shouldItemRender={this.shouldItemRender}
        value={autocompleteLabel}
        onChange={this.onChange}
        onSelect={this.onSelect}
        inputProps={{
          className: `tagAutocomplete ${inputCss.tagAutocomplete}`,
          placeholder,
        }}
        wrapperStyle={{}}
        renderMenu={this.renderMenu}
      />
    );
  };

  renderMenu = (items: any) => (
    <div className={`tagMenu ${css.tagMenu}`}>{items}</div>
  );

  renderItem = (checkbox: Checkbox, highlighted: boolean) => (
    <div
      key={checkbox.id}
      className={`tagLabel ${highlighted ? css.tagHighlighted : ''} ${
        css.tagLabel
      }`}
    >
      {checkbox.label}
    </div>
  );

  render() {
    const { id } = this.props;
    const { checkboxes } = this.state;
    return (
      <div id={id}>
        {this.displayAutocomplete()}
        <div className={css.tagCheckboxes}>
          {checkboxes.map((checkbox: Checkbox) => this.displayCheckbox(checkbox))}
        </div>
      </div>
    );
  }
}
