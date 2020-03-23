// @flow
import React, { useState } from 'react';
import Autosuggest from 'react-autosuggest';
import type { Checkbox } from './utils';
import { Utils } from '../../utils';
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

export function InputTag({
  id,
  name,
  placeholder,
  checkboxes: defaultCheckboxes,
  onChange,
  onCheckboxChange,
}: Props) {
  const [checkboxes, setCheckboxes] = useState<Checkbox[]>(defaultCheckboxes);
  const [suggestions, setSuggestions] = useState<Checkbox[]>(defaultCheckboxes);
  const [autocompleteLabel, setAutocompleteLabel] = useState<
    string | void | null,
  >(undefined);

  const check = (inputId: string, checked: boolean) => {
    const newCheckboxes = checkboxes.map((checkbox: Checkbox) => {
      const newCheckbox = { ...checkbox };
      if (newCheckbox.id === inputId) {
        newCheckbox.checked = checked;
        if (onCheckboxChange) {
          onCheckboxChange(newCheckbox);
        }
      }
      return newCheckbox;
    });

    if (checked) {
      setAutocompleteLabel(undefined);
    }
    setCheckboxes(newCheckboxes);
  };

  const checkboxChange = (checkbox: { checked: boolean, id: string }) => {
    const { checked, id: inputId } = checkbox;
    if (
      !checked
      && checkboxes.filter((item: Checkbox) => item.id === inputId && item.checked)
        .length
    ) {
      check(inputId, false);
    }
  };

  const getSuggestions = (label: string) => {
    const inputValue = label.trim().toLowerCase();
    const inputLength = inputValue.length;
    const newSuggestions: Checkbox[] = inputLength === 0
      ? checkboxes
      : checkboxes.filter(
        (checkbox: Checkbox) => checkbox.label.toLowerCase().indexOf(inputValue) > -1,
      );
    return newSuggestions;
  };

  const getSuggestionValue = (checkbox: Checkbox) => (checkbox.label === autocompleteLabel ? checkbox.label : '');

  const onSuggestionsFetchRequested = (valueProp: { value: string }) => {
    const { value } = valueProp;
    const newSuggestions = getSuggestions(value);
    setSuggestions(newSuggestions);
  };

  const onSuggestionsClearRequested = () => {
    setSuggestions(defaultCheckboxes);
  };

  const labelExistsUnchecked = (label: string) => {
    if (!label.length) return null;
    const checkboxWithLabel = checkboxes.filter(
      (checkbox: Checkbox) => checkbox.label.toLowerCase() === label.toLowerCase()
        && !checkbox.checked,
    );
    return checkboxWithLabel.length && checkboxWithLabel[0].id;
  };

  const onAutocompleteChange = (
    e: SyntheticEvent<HTMLInputElement>,
    { newValue }: { newValue: string },
  ) => {
    setAutocompleteLabel(newValue);
  };

  const onSelect = (
    event: SyntheticEvent<HTMLInputElement>,
    { suggestion, method }: { suggestion: Checkbox, method: string },
  ) => {
    if (method === 'enter') {
      event.preventDefault();
    }
    const inputId = labelExistsUnchecked(suggestion.label);
    if (inputId) {
      check(inputId, true);
    }
  };

  const displayCheckbox = (checkbox) => {
    if (!checkbox.checked) return null;
    return (
      <InputCheckbox
        id={checkbox.id}
        name={name}
        key={Utils.randomString()}
        value={checkbox.value}
        label={checkbox.label}
        onChange={checkboxChange}
        checked
      />
    );
  };

  const shouldRenderSuggestions = () => true;

  const onKeyPress = (e: SyntheticKeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter' && onChange) {
      e.preventDefault();
      onChange({ label: autocompleteLabel, checkboxes });
    }
  };

  const renderSuggestion = (checkbox: Checkbox) => (
    <div className="tagLabel">{checkbox.label}</div>
  );

  const displayAutocomplete = () => (
    <Autosuggest
      className="tagMenu"
      id={`autosuggest-${id}`}
      suggestions={suggestions}
      onSuggestionsFetchRequested={onSuggestionsFetchRequested}
      onSuggestionsClearRequested={onSuggestionsClearRequested}
      onSuggestionSelected={onSelect}
      highlightFirstSuggestion
      shouldRenderSuggestions={shouldRenderSuggestions}
      renderSuggestion={renderSuggestion}
      getSuggestionValue={getSuggestionValue}
      theme={css}
      inputProps={{
        onChange: onAutocompleteChange,
        value: autocompleteLabel || '',
        className: `tagAutocomplete ${inputCss.tagAutocomplete}`,
        onKeyPress,
        placeholder,
      }}
    />
  );

  return (
    <div id={id}>
      {displayAutocomplete()}
      <div className={css.tagCheckboxes}>
        {checkboxes.map((checkbox: Checkbox) => displayCheckbox(checkbox))}
      </div>
    </div>
  );
}
