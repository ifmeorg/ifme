import React from 'react';
import { Row, Col } from 'antd';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import MomentCard from 'bundles/momentsApp/components/MomentCard';

storiesOf('MomentCards', module)
  .add('MomentCard', withInfo({})(() =>
    (<Row>
      <Col span={12}>
        <MomentCard
          action={{
            edit: () => {},
            delete: () => {},
            viewer: () => {},
          }}
          item={{
            name: 'Real Moment',
            category: ['FRIENDS', 'FAMILY'],
            mood: ['ANXIOUS', 'HELPFUL'],
          }}
          date="Created 2 Days ago"
          cardType="Normal"
        />
      </Col>
    </Row>),
  ))
  .add('MomentCardExample', withInfo({})(() =>
    (<Row>
      <Col span={12}>
        <MomentCard
          action={{
            viewer: () => {},
          }}
          item={{
            name: 'Example Moment: Panicking over interview tomorrow!',
            category: ['CAREER'],
            mood: ['NERVOUS', 'ANXIOUS', 'HELPFUL'],
          }}
          date=""
          cardType="Example"
        />
      </Col>
    </Row>),
  ))
  .add('MomentCardDraft', withInfo({})(() =>
    (<Row>
      <Col span={12}>
        <MomentCard
          action={{
            edit: () => {},
            delete: () => {},
            viewer: () => {},
          }}
          item={{
            name: 'Real Moment',
            category: ['FRIENDS', 'FAMILY'],
            mood: ['ANXIOUS', 'HELPFUL'],
          }}
          date=""
          cardType="Draft"
          draftText="DRAFT"
        />
      </Col>
    </Row>),
  ));
