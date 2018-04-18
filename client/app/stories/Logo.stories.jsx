import { Col, Row } from 'antd';
import React from 'react';
import { storiesOf } from '@storybook/react';

import 'bundles/shared/components/_global.scss';

import Logo, { LogoSmall } from 'bundles/shared/components/Logo';

storiesOf('Logo', module)
  .add('Regular and Small', () => (
    <Row gutter={24}>
      <Col span={12}>
        <Logo />
      </Col>
      <Col span={12}>
        <LogoSmall />
      </Col>
    </Row>
  ));
