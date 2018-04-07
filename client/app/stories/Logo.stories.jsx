import { Col, Row } from 'antd';
import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import 'bundles/shared/components/_globals.scss';

import Logo, { LogoSmall } from 'bundles/shared/components/Logo';

const withSource = el => withInfo()(() => el);

storiesOf('Logo', module)
  .add('Regular and Small', withSource(
    <Row>
      <Col span={12}>
        <Logo />
      </Col>
      <Col span={12}>
        <LogoSmall />
      </Col>
    </Row>,
  ));
