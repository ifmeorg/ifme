import React from 'react';
import { storiesOf } from '@storybook/react';
import { Bullet } from '../components/Bullet';

storiesOf('Bullet', module)
  .add('BulletActive', () => <Bullet active label="1" />) 
  .add('BulletNormal', () => <Bullet normal label="1" />);
