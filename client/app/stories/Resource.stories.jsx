import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import Resource from '../bundles/shared/components/Resource';

storiesOf('Resource', module)
  .add('Tagged Resource', withInfo({})(() =>
    (<div style={{ backgroundColor: '#6D0839' }}>
      <Resource
        tagged
        tags={['open_source', 'tech_industry', 'free', 'workplace', 'podcast', 'books']}
        name={'LifeSIGNS: Self Injury Guidance & Network Support (UK)'}
        link={'http://www.lifesigns.org.uk/'}
      />
    </div>),
  ))

  .add('External Resource', withInfo({})(() =>
    (<div style={{ backgroundColor: '#6D0839' }}>
      <Resource
        external
        name={'Invisible Illnesses: depression is an ocean'}
        link={'www.if-me.org'}
        author={'Desi Rottman'}
      />
    </div>),
  ));
