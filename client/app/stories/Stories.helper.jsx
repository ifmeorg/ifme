// @flow
import { Col, Row } from 'antd';
import React, { type StatelessFunctionalComponent } from 'react';

type SingleColumnLayoutProps = {
  children: React$Node,
};

const SingleColumnLayout: StatelessFunctionalComponent<SingleColumnLayoutProps> =
  ({ children }: SingleColumnLayoutProps) => (
    <Row style={{ padding: '24px' }}>
      <Col span={24}>
        {children}
      </Col>
    </Row>
  );

export default {
  SingleColumnLayout,
};
