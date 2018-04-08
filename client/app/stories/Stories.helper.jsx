// @flow
import { Col, Row } from 'antd';
import React, { type Node, type StatelessFunctionalComponent } from 'react';
import { withInfo } from '@storybook/addon-info';

type Props = {
  children: Node,
};

const SingleColumnLayout: StatelessFunctionalComponent<Props> = ({ children }: Props) => (
  <Row style={{ backgroundColor: '#666', padding: '24px' }}>
    <Col span={24}>
      {children}
    </Col>
  </Row>
);

export function withSource(el: Node) {
  return withInfo()(() => el);
}

export {
  SingleColumnLayout,
};

export default withSource;
