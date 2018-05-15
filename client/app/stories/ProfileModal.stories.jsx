import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import ProfileModal from 'bundles/shared/components/ProfileModal';

const withSource = el => withInfo()(() => el);

storiesOf('ProfileModal', module)
  .add('With name', withSource(
    <ProfileModal
      name="Julia Nguyen"
      location="Toronto, Canada"
      github="Julia Nguyen"
      bio="Being open and honest about my journey with obsessive-compulsive disorder, anxiety, and
        depression helps me to accept myself and reach out for support. My hope is to encourage
        others to feel more comfortable about sharing their experiences. Growing up as a daughter
        of Vietnamese refugee parents, it was difficult to talk about mental illness openly. I
        created if me as a tool to engage loved ones in mental health conversations. Working on
        the project openly has helped me to further explore my own mental health."
    />,
  ));
