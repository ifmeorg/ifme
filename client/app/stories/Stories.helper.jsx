import { Col, Row } from 'antd';
import React, { type StatelessFunctionalComponent } from 'react';
import { withInfo } from '@storybook/addon-info';

const SingleColumnLayout = ({ children }): StatelessFunctionalComponent => (
  <Row style={{ backgroundColor: '#666', padding: '24px' }}>
    <Col span={24}>
      {children}
    </Col>
  </Row>
);

export function withSource(el) {
  return withInfo()(() => el);
}

export {
  SingleColumnLayout,
}

export default withSource;
