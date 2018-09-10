import React from 'react';
import { action } from '@storybook/addon-actions';
import { storiesOf } from '@storybook/react';
import { availableLocalesAsSelectOptions as localeOptions } from '../libs/i18n/I18nUtils';
import { DropdownFillSmall } from '../components/Dropdown/DropdownFillSmall';
import { DropdownGhost } from '../components/Dropdown/DropdownGhost';
import { DropdownGhostSmall } from '../components/Dropdown/DropdownGhostSmall';

const optionsWithSelected = [
  {
    label: 'Option 1',
    value: 1,
  },
  {
    label: 'Option 2',
    value: 2,
    selected: true,
  },
];

storiesOf('Dropdown', module)
  .add('DropdownGhost with no selected value', () => (
    <DropdownGhost
      id="dropdownGhost"
      name="dropdownGhost"
      options={localeOptions}
      onChange={action('DropdownGhost.onChange')}
    />
  ))
  .add('DropdownGhost with a selected value', () => (
    <DropdownGhost
      id="dropdownGhost"
      name="dropdownGhost"
      options={optionsWithSelected}
      onChange={action('DropdownGhost.onChange')}
    />
  ))
  .add('DropdownGhostSmall with no selected value', () => (
    <DropdownGhostSmall
      id="dropdownGhostSmall"
      name="dropdownGhostSmall"
      options={localeOptions}
      onChange={action('DropdownGhostSmall.onChange')}
    />
  ))
  .add('DropdownFillSmall with no selected value', () => (
    <DropdownFillSmall
      id="dropdownFillSmall"
      name="dropdownFillSmall"
      options={localeOptions}
      onChange={action('DropdownFillSmall.onChange')}
    />
  ));
