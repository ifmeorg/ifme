// @flow
import React from 'react';
import Autosuggest from 'react-autosuggest';
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
  suggestions: Checkbox[]
};


export class InputTag extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { checkboxes: props.checkboxes, autoHighlight: false, suggestions: [], autocompleteLabel: '' };
  }

  check = (id: string, checked: boolean) => {
    this.setState((prevState: State) => {
      let { checkboxes } = prevState;
      checkboxes = checkboxes.map((checkbox: Checkbox) => {
        const newCheckbox = { ...checkbox };
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
  
  getSuggestions = (autocompleteLabel: string) => {
    const inputValue = autocompleteLabel.trim().toLowerCase();
    const inputLength = inputValue.length;
    const { checkboxes } = this.state;
    const suggestions: Checkbox[] =  inputLength === 0 ? [] : checkboxes.filter(
      (checkbox: Checkbox) => checkbox.label.toLowerCase().slice(0, inputLength) === inputValue);
    return suggestions
  };

  getSuggestionValue = (checkbox: Checkbox, label: string) => {
    return checkbox.label === this.state.autocompleteLabel ? checkbox.label : '';
  }

  renderSuggestion = (checkbox: Checkbox, label: string) => (
    <div>
      {checkbox.label}
    </div>
  );

  onSuggestionsFetchRequested = ({ value }: {value: string}) => {
    const newSuggestions = this.getSuggestions(value)
    this.setState({
      suggestions: newSuggestions
    });
  };
  
  onSuggestionsClearRequested = () => {
    this.setState({
      suggestions: []
    });
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

  onAutocompleteChange = (e: SyntheticEvent<HTMLInputElement>, { newValue }: {newValue: string}) => {
    this.setState({
      autocompleteLabel: newValue,
    });
  };

  onSelect = (event: SyntheticEvent<HTMLInputElement>,  { suggestion }: {suggestion: Checkbox}) => {
    const id = this.labelExistsUnchecked(suggestion.label);
    if (id) {
      this.check(id, true);
    }
  };

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
    const { autocompleteLabel, checkboxes, autoHighlight, suggestions } = this.state;
    return (
      <Autosuggest
      id={`autosuggest-${this.props.id}`}
      suggestions={suggestions}
      onSuggestionsFetchRequested={this.onSuggestionsFetchRequested}
      onSuggestionsClearRequested={this.onSuggestionsClearRequested}
      onSuggestionSelected={this.onSelect}
      renderSuggestion={this.renderSuggestion}
      getSuggestionValue={this.getSuggestionValue}
      theme={css}
      inputProps={{
            onChange: this.onAutocompleteChange,
            value : autocompleteLabel ? autocompleteLabel : "",
            className: `tagAutocomplete ${inputCss.tagAutocomplete}`,
            onKeyPress: this.onKeyPress,
            placeholder,
          }}
      />
    );
  };
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
