import { Col, Row } from 'antd';
import React from 'react';
import { storiesOf } from '@storybook/react';

import { Logo, LogoSmall } from '../components/Logo';

storiesOf('Logo', module).add('Regular and Small', () => (
  <Row gutter={24}>
    <Col span={12}>
      <Logo />
    </Col>
    <Col span={12}>
      <LogoSmall />
    </Col>
  </Row>
));
