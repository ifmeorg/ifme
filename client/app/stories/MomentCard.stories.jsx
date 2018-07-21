import 'font-awesome/scss/font-awesome.scss';
import { Row, Col } from 'antd';
import React from 'react';
import { action } from '@storybook/addon-actions';
import { storiesOf } from '@storybook/react';
import { MomentCard } from '../components/MomentCard';

const tripleColumnize = card => {
  const cardAndCol = key => (
    <Col key={key} span={8}>
      {card}
    </Col>
  );
  return <Row gutter={24}>{[cardAndCol(1), cardAndCol(2), cardAndCol(3)]}</Row>;
};

storiesOf('MomentCards', module)
  .add('MomentCardDated', () =>
    tripleColumnize(
      <MomentCard
        action={{
          edit: action('MomentCardDated.edit.onClick'),
          delete: action('MomentCardDated.delete.onClick'),
          viewer: action('MomentCardDated.viewer.onClick'),
        }}
        item={{
          name: 'Real Moment',
          category: ['FRIENDS', 'FAMILY'],
          mood: ['ANXIOUS', 'HELPFUL'],
        }}
        date="Created 2 Days ago"
      />,
    ),
  )
  .add('MomentCardNoDate', () =>
    tripleColumnize(
      <MomentCard
        action={{
          viewer: action('MomentCardNoDate.viewer.onClick'),
        }}
        item={{
          name: 'Example Moment: Panicking over interview tomorrow!',
          category: ['CAREER'],
          mood: ['NERVOUS', 'ANXIOUS', 'HELPFUL'],
        }}
      />,
    ),
  )
  .add('MomentCardDraft', () =>
    tripleColumnize(
      <MomentCard
        cardType="Draft"
        action={{
          edit: action('MomentCardDraft.edit.onClick'),
          delete: action('MomentCardDraft.delete.onClick'),
          viewer: action('MomentCardDraft.viewer.onClick'),
        }}
        item={{
          name: 'Real Moment',
          category: ['FRIENDS', 'FAMILY'],
          mood: ['ANXIOUS', 'HELPFUL'],
        }}
        draftText="DRAFT"
      />,
    ),
  );
