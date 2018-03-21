import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import MomentCard from 'bundles/momentCard/components/MomentCard';

storiesOf('MomentCards', module)
  .add('MomentCard', withInfo({})(() =>
    (<MomentCard
      item={{
        name: 'Real Moment',
        category: ['FRIENDS', 'FAMILY'],
        mood: ['ANXIOUS', 'HELPFUL'],
      }}
      date="Created 2 Days ago"
      cardType="Normal"
      viewersText="Viewers"
    />),
  ))
  .add('MomentCardExample', withInfo({})(() =>
    (<MomentCard
      item={{
        name: 'Example Moment: Panicking over interview tomorrow!',
        category: ['CAREER'],
        mood: ['NERVOUS', 'ANXIOUS', 'HELPFUL'],
      }}
      date=""
      cardType="Example"
      viewersText="Viewers"
    />),
  ))
  .add('MomentCardDraft', withInfo({})(() =>
    (<MomentCard
      item={{
        name: 'Real Moment',
        category: ['FRIENDS', 'FAMILY'],
        mood: ['ANXIOUS', 'HELPFUL'],
      }}
      date=""
      cardType="Draft"
      draftText="DRAFT"
      viewersText="Viewers"
    />),
  ));
