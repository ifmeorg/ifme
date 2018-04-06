import 'font-awesome/scss/font-awesome.scss';
import React from 'react';
import { Row, Col } from 'antd';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import MomentCard from 'bundles/momentsApp/components/MomentCard';

const withSource = el => withInfo()(() => el);
const fn = () => { };
const tripleColumnize = (card) => {
  const cardAndCol = (
    <Col span={8}>
      {card}
    </Col>
  );
  return (
    <Row gutter={24} style={{ padding: '24px' }}>
      {[cardAndCol, cardAndCol, cardAndCol]}
    </Row>
  );
};

storiesOf('MomentCards', module)
  .add('MomentCard', withSource(
    tripleColumnize(
      <MomentCard
        action={{
          edit: fn,
          delete: fn,
          viewer: fn,
        }}
        item={{
          name: 'Real Moment',
          category: ['FRIENDS', 'FAMILY'],
          mood: ['ANXIOUS', 'HELPFUL'],
        }}
        date="Created 2 Days ago"
      />,
    ),
  ))
  .add('MomentCardExample', withSource(
    tripleColumnize(
      <MomentCard
        action={{
          viewer: fn,
        }}
        item={{
          name: 'Example Moment: Panicking over interview tomorrow!',
          category: ['CAREER'],
          mood: ['NERVOUS', 'ANXIOUS', 'HELPFUL'],
        }}
      />,
    ),
  ))
  .add('MomentCardDraft', withSource(
    tripleColumnize(
      <MomentCard
        cardType="Draft"
        action={{
          edit: fn,
          delete: fn,
          viewer: fn,
        }}
        item={{
          name: 'Real Moment',
          category: ['FRIENDS', 'FAMILY'],
          mood: ['ANXIOUS', 'HELPFUL'],
        }}
        draftText="DRAFT"
      />,
    ),
  ));
