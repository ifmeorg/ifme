
import React from 'react';
import { storiesOf } from '@storybook/react';

import Blockquote from 'bundles/shared/components/Blockquote';
import { SingleColumnLayout } from './Stories.helper';

storiesOf('Blockquotes', module)
  .add('Blockquote', () => (
    <SingleColumnLayout>
      <Blockquote text="It's not just all in your head, it's all around you. We can heal together." author="❤️" />
    </SingleColumnLayout>
  ));
