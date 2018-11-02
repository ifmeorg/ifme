// @flow
import React from 'react';
import Autocomplete from 'react-autocomplete';
import type { Checkbox } from './utils';
import { InputCheckbox } from './InputCheckbox';
import inputCss from './Input.scss';
import css from './InputTag.scss';

export type Props = {
  id: string,
  name: string,
  placeholder?: string,
  checkboxes: Checkbox[],
  onChange?: Function,
  onCheckboxChange?: Function,
};

export type State = {
  checkboxes: Checkbox[],
  autocompleteLabel?: string,
  autoHighlight: boolean,
};

export class InputTag extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { checkboxes: props.checkboxes, autoHighlight: false };
  }

  check = (id: string, checked: boolean) => {
    this.setState((prevState: State) => {
      let { checkboxes } = prevState;
      checkboxes = checkboxes.map((checkbox: Checkbox) => {
        const newCheckbox = Object.assign({}, checkbox);
        if (newCheckbox.id === id) {
          newCheckbox.checked = checked;
          const { onCheckboxChange } = this.props;
          if (onCheckboxChange) {
            onCheckboxChange(newCheckbox);
          }
        }
        return newCheckbox;
      });
      return checked
        ? { checkboxes, autocompleteLabel: undefined }
        : { checkboxes };
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

  shouldItemRender = (checkbox: Checkbox, label: string) => {
    const checkboxLabel = checkbox.label.toLowerCase();
    return checkboxLabel.indexOf(label.toLowerCase()) > -1;
  };

  labelExistsUnchecked = (label: string) => {
    if (!label.length) return null;
    const { checkboxes } = this.state;
    const checkboxWithLabel = checkboxes.filter(
      (checkbox: Checkbox) => checkbox.label.toLowerCase() === label.toLowerCase()
        && !checkbox.checked,
    );
    return checkboxWithLabel.length && checkboxWithLabel[0].id;
  };

  onAutocompleteChange = (e: SyntheticEvent<HTMLInputElement>) => {
    const { value } = e.currentTarget;
    this.setState({
      autocompleteLabel: value,
      autoHighlight: !!this.labelExistsUnchecked(value),
    });
  };

  onSelect = (label: string) => {
    const id = this.labelExistsUnchecked(label);
    if (id) {
      this.check(id, true);
    }
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

  onKeyPress = (e: SyntheticKeyboardEvent<HTMLInputElement>) => {
    const { onChange } = this.props;
    const { autocompleteLabel, checkboxes } = this.state;
    if (e.key === 'Enter' && onChange) {
      e.preventDefault();
      onChange({ label: autocompleteLabel, checkboxes });
    }
  };

  displayAutocomplete = () => {
    const { placeholder } = this.props;
    const { autocompleteLabel, checkboxes, autoHighlight } = this.state;
    return (
      <Autocomplete
        getItemValue={this.getLabel}
        items={checkboxes}
        renderItem={this.renderItem}
        shouldItemRender={this.shouldItemRender}
        value={autocompleteLabel}
        onChange={this.onAutocompleteChange}
        onSelect={this.onSelect}
        inputProps={{
          className: `tagAutocomplete ${inputCss.tagAutocomplete}`,
          onKeyPress: this.onKeyPress,
          placeholder,
        }}
        wrapperStyle={{}}
        renderMenu={this.renderMenu}
        autoHighlight={autoHighlight}
      />
    );
  };

  renderMenu = (items: any) => (
    <div className={`tagMenu ${items.length ? css.tagMenu : ''}`}>{items}</div>
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
