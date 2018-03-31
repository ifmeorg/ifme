import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import Input from 'bundles/shared/components/Input';

storiesOf('Input', module)
  .add('Input Light', withInfo({})(() =>
    <Input label="Hello" placeholder="Placeholder" />,
  ))
  .add('Input Dark', withInfo({})(() =>
    <Input dark label="Hello" placeholder="Placeholder" />,
  ))
  .add('Input Light (Large)', withInfo({})(() =>
    <Input large label="Hello" placeholder="Placeholder" />,
  ))
  .add('Input Dark (Large)', withInfo({})(() =>
    <Input dark large label="Hello" placeholder="Placeholder" />,
  ));
