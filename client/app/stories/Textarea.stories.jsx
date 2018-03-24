import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import Textarea from 'bundles/shared/components/Textarea';

storiesOf('Textarea', module)
  .add('Textarea', withInfo({})(() =>
    <Textarea rows={6} label="What happened and how do you feel?" placeholder="I felt..." />,
  ));
