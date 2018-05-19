import React from 'react';
import { storiesOf } from '@storybook/react';

import Heading from 'bundles/shared/components/Heading';
import { SingleColumnLayout, withSource } from './Stories.helper';

storiesOf('Headings', module)
  .add('Heading Large', withSource(
    <SingleColumnLayout>
      <Heading large label={'Better Communication with loved ones leads to better mental health.'} />
    </SingleColumnLayout>,
  ))
  .add('Heading Normal', withSource(
    <SingleColumnLayout>
      <Heading label={'A community for mental health experiences.'} />
    </SingleColumnLayout>,
  ))
  .add('Heading Small', withSource(
    <SingleColumnLayout>
      <Heading small label={'A community for mental health experiences.'} />
    </SingleColumnLayout>,
  ))
  .add('Text', withSource(
    <SingleColumnLayout>
      <Heading text label={'We need each others support to break down stigmas.'} />
    </SingleColumnLayout>,
  ));
