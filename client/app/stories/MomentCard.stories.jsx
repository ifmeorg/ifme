import 'font-awesome/scss/font-awesome.scss';
import React from 'react';
import { Row, Col } from 'antd';
import { storiesOf } from '@storybook/react';

import MomentCard from 'bundles/momentsApp/components/MomentCard';

const fn = () => {};
const tripleColumnize = (card) => {
  const cardAndCol = key => (
    <Col key={key} span={8}>
      {card}
    </Col>
  );
  return (
    <Row gutter={24}>
      {[cardAndCol(1), cardAndCol(2), cardAndCol(3)]}
    </Row>
  );
};

storiesOf('MomentCards', module)
  .add('MomentCard', () => (
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
    )
  ))
  .add('MomentCardExample', () => (
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
    )
  ))
  .add('MomentCardDraft', () => (
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
    )
  ));
