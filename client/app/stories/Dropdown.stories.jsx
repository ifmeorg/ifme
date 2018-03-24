import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import {
  DropdownFillSmall,
  DropdownGhost,
  DropdownGhostSmall,
} from 'bundles/shared/components/Dropdown';
import I18nWrapper from './I18nWrapper';

storiesOf('Dropdown', module)
  .add('DropdownGhost', withInfo()(() => (
    <DropdownGhost locale={'en'} localeList={{ en: 'English', fr: 'French' }} />
  )))
  .add('DropdownGhostSmall', withInfo()(() => (
    <DropdownGhostSmall locale={'it'} localeList={{ en: 'English', fr: 'French', it: 'Italian' }} />
  )))
  .add('DropdownFillSmall', withInfo()(() => (
    <DropdownFillSmall locale={'ptbr'} />
  )))
  // TODO: Need to "unwrap" the component so that Story Source doesn't just display <I18nWrapper />
  .add('ChangingLocales', withInfo()(() =>
    <I18nWrapper />,
  ));
