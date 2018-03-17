import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import Heading from 'bundles/shared/components/Heading';

loadLocales();

storiesOf('Headings', module)
  .add('Heading Large', withInfo({})(() =>
    <Heading large label={'Better Communication with loved ones leads to better mental health.'} />,
  ))
  .add('Heading Normal', withInfo({})(() =>
    <Heading label={'A community for mental health experiences.'} />,
  ))
  .add('Heading Small', withInfo({})(() =>
    <Heading small label={'A community for mental health experiences.'} />,
  ))
  .add('Text', withInfo({})(() =>
    <Heading text label={'We need each others support to break down stigmas.'} />,
  ));
