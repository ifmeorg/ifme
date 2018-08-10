import React from 'react';
import { availableLocalesAsSelectOptions as localeOptions } from 'libs/i18n/I18nUtils';
import { action } from '@storybook/addon-actions';
import { storiesOf } from '@storybook/react';
import { DropdownFillSmall } from '../components/Dropdown/DropdownFillSmall';
import { DropdownGhost } from '../components/Dropdown/DropdownGhost';
import { DropdownGhostSmall } from '../components/Dropdown/DropdownGhostSmall';

storiesOf('Dropdown', module)
  .add('DropdownGhost', () => (
    <DropdownGhost
      options={localeOptions}
      onChange={action('DropdownGhost.onChange')}
    />
  ))
  .add('DropdownGhostSmall', () => (
    <DropdownGhostSmall
      options={localeOptions}
      onChange={action('DropdownGhostSmall.onChange')}
    />
  ))
  .add('DropdownFillSmall', () => (
    <DropdownFillSmall
      options={localeOptions}
      onChange={action('DropdownFillSmall.onChange')}
    />
  ));
