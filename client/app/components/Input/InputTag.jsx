// @flow
/* eslint-disable react/jsx-props-no-spreading */
import React, { useState } from 'react';
import type { Node } from 'react';
import { useCombobox } from 'downshift';
import { Utils } from 'utils';
import { InputCheckbox } from 'components/Input/InputCheckbox';
import type { Checkbox } from './utils';
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
}: Props): Node {
  const [checkboxes, setCheckboxes] = useState<Checkbox[]>(defaultCheckboxes);
  const [inputValue, setInputValue] = useState<string>('');

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

  const getSuggestions = (label: string): Checkbox[] => {
    const value = label.trim().toLowerCase();
    if (value.length === 0) return checkboxes;
    return checkboxes.filter(
      (checkbox: Checkbox) => checkbox.label.toLowerCase().indexOf(value) > -1,
    );
  };

  const labelExistsUnchecked = (label: string) => {
    if (!label.length) return null;
    const checkboxWithLabel = checkboxes.filter(
      (checkbox: Checkbox) => checkbox.label.toLowerCase() === label.toLowerCase()
        && !checkbox.checked,
    );
    return checkboxWithLabel.length && checkboxWithLabel[0].id;
  };

  const suggestions = getSuggestions(inputValue);

  const {
    isOpen,
    getMenuProps,
    getInputProps,
    getItemProps,
    highlightedIndex,
    openMenu,
  } = useCombobox<Checkbox>({
    items: suggestions,
    inputValue,
    selectedItem: null,
    defaultHighlightedIndex: 0,
    itemToString: (item: ?Checkbox) => (item ? item.label : ''),
    onInputValueChange: ({ inputValue: newInputValue }) => {
      setInputValue(newInputValue || '');
    },
    stateReducer: (state, { type, changes }) => {
      switch (type) {
        case useCombobox.stateChangeTypes.InputKeyDownEnter:
        case useCombobox.stateChangeTypes.ItemClick:
          // keep the menu open and reset the search after a pick
          return {
            ...changes,
            isOpen: true,
            inputValue: '',
            highlightedIndex: 0,
          };
        case useCombobox.stateChangeTypes.InputClick:
          // clicking the input always reveals the options, never toggles them off
          return { ...changes, isOpen: true };
        default:
          return changes;
      }
    },
    onStateChange: ({ type, selectedItem }) => {
      switch (type) {
        case useCombobox.stateChangeTypes.InputKeyDownEnter:
        case useCombobox.stateChangeTypes.ItemClick: {
          if (!selectedItem) return;
          const inputId = labelExistsUnchecked(selectedItem.label);
          if (inputId) {
            check(inputId, true);
          }
          break;
        }
        default:
          break;
      }
    },
  });

  const onInputKeyDown = (e: SyntheticKeyboardEvent<HTMLInputElement>) => {
    // no suggestion to select: surface the typed value (e.g. to create a new tag)
    if (e.key === 'Enter' && suggestions.length === 0 && onChange) {
      e.preventDefault();
      onChange({ label: inputValue, checkboxes });
    }
  };

  const displayCheckbox = (checkbox: Checkbox): Node => {
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

  return (
    <div id={id}>
      <div className={`tagMenu ${css.tagMenu}`}>
        <input
          {...getInputProps({
            id: `autosuggest-${id}`,
            className: `tagAutocomplete ${inputCss.tagAutocomplete}`,
            placeholder,
            onFocus: () => {
              if (!isOpen) openMenu();
            },
            onKeyDown: onInputKeyDown,
          })}
        />
        <ul
          {...getMenuProps()}
          className={`${css.suggestionsList} ${
            isOpen && suggestions.length ? css.suggestionsContainerOpen : ''
          }`}
        >
          {isOpen
            && suggestions.map((checkbox: Checkbox, index: number) => (
              <li
                className={
                  index === highlightedIndex
                    ? css.suggestionHighlighted
                    : css.suggestion
                }
                key={checkbox.id}
                {...getItemProps({ item: checkbox, index })}
              >
                <div className="tagLabel">{checkbox.label}</div>
              </li>
            ))}
        </ul>
      </div>
      <div className={css.tagCheckboxes}>
        {checkboxes.map((checkbox: Checkbox) => displayCheckbox(checkbox))}
      </div>
    </div>
  );
}
