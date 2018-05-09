import { Col, Row } from 'antd';
import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import Pagination from '../bundles/shared/components/Pagination/Pagination.jsx';

const withSource = el => withInfo()(() => el);

storiesOf('Pagination', module)
   .add('Demo', withSource(
      <Row gutter={24} style={{ padding: '24px', background: '#AAAAAA' }}>
         <Col span={12}>
            <Pagination />
         </Col>
      </Row>
   ));
   