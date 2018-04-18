import React from 'react';
import { storiesOf } from '@storybook/react';

import {
  DropdownFillSmall,
  DropdownGhost,
  DropdownGhostSmall,
} from 'bundles/shared/components/Dropdown';
import { availableLocalesAsSelectOptions as localeOptions } from 'libs/i18n/I18nUtils';

storiesOf('Dropdown', module)
  .add('DropdownGhost', () => (
    <DropdownGhost options={localeOptions} />
  ))
  .add('DropdownGhostSmall', () => (
    <DropdownGhostSmall options={localeOptions} />
  ))
  .add('DropdownFillSmall', () => (
    <DropdownFillSmall options={localeOptions} />
  ));
