import React from 'react';
import { action } from '@storybook/addon-actions';
import { storiesOf } from '@storybook/react';

import {
  DropdownFillSmall,
  DropdownGhost,
  DropdownGhostSmall,
} from 'bundles/shared/components/Dropdown';
import { availableLocalesAsSelectOptions as localeOptions } from 'libs/i18n/I18nUtils';

storiesOf('Dropdown', module)
  .add('DropdownGhost', () => (
    <DropdownGhost options={localeOptions} onChange={action('DropdownGhost.onChange')} />
  ))
  .add('DropdownGhostSmall', () => (
    <DropdownGhostSmall options={localeOptions} onChange={action('DropdownGhostSmall.onChange')} />
  ))
  .add('DropdownFillSmall', () => (
    <DropdownFillSmall options={localeOptions} onChange={action('DropdownFillSmall.onChange')} />
  ));
