// @flow
import React from 'react';
// TODO: react-autocomplete is no longer mantained,
// move to react-autosuggestion which is using latest version of React
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
  suggestions: string[]
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
  
  getSuggestions = autocompleteLabel => {
    const inputValue = autocompleteLabel.trim().toLowerCase();
    const inputLength = inputValue.length;
  
    return inputLength === 0 ? [] : checkboxes.filter(checkbox =>
      checkbox.label.toLowerCase().slice(0, inputLength) === inputValue
      );
  };

  getSuggestionValue = (checkbox: Checkbox, label: string) => {
    return checkbox.label === autocompleteLabel ? checkbox.label : '';
  }

  renderSuggestion = (checkbox: Checkbox, label: string) => (
    <div>
      {checkbox.label.toLowerCase()}
    </div>
  );

  onSuggestionsFetchRequested = ({autocompleteLabel}) => {
    this.setState({
      suggestions: getSuggestions(autocompleteLabel)
    });
  };
  
  onSuggestionsClearRequested = () => {
    this.setState({
      suggestions: []
    });
  };


  // shouldItemRender = (checkbox: Checkbox, label: string) => {
  //   const checkboxLabel = checkbox.label.toLowerCase();
  //   return checkboxLabel.indexOf(label.toLowerCase()) > -1;
  // };

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
    this.state.suggestions.push(value);
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

  // getLabel = (checkbox: Checkbox) => checkbox.label;

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
      suggestions={suggestions}
      onSuggestionsFetchRequested={this.onSuggestionsFetchRequested}
      onSuggestionsClearRequested={this.onSuggestionsClearRequested}
      renderSuggestion={this.getSuggestionValue}
      getSuggestionValue={this.renderSuggestion}
      inputProps={{
            className: `tagAutocomplete ${inputCss.tagAutocomplete}`,
            onKeyPress: this.onKeyPress,
            placeholder,
          }}
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
