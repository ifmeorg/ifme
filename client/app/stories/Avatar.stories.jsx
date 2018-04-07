import { Col, Row } from 'antd';
import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import Avatar from 'bundles/shared/components/Avatar';
import photoJulia from 'app/assets/images/contributors/julia_nguyen.jpg';
import photoTara from 'app/assets/images/contributors/tara_swenson.jpg';

const withSource = el => withInfo()(() => el);

storiesOf('Avatar', module)
  .add('With name', withSource(
    <Row style={{ backgroundColor: '#aaa' }}>
      <Col span={8}>
        <Avatar src={photoJulia} name="Julia &ldquo;Fleurchild&rdquo; Nguyen" displayname />
      </Col>
      <Col span={8}>
        <Avatar src={photoTara} name="Tara Swenson" displayname />
      </Col>
      <Col span={8}>
        <Avatar src="NonExistentFile.jpg" name="Default On Loading Error" displayname />
      </Col>
    </Row>,
  ))
  .add('Without name', withSource(
    <Row style={{ backgroundColor: '#aaa' }}>
      <Col span={8}>
        <Avatar src={photoJulia} name="Julia &ldquo;Fleurchild&rdquo; Nguyen" />
      </Col>
      <Col span={8}>
        <Avatar src={photoTara} name="Tara Swenson" />
      </Col>
      <Col span={8}>
        <Avatar src="NonExistentFile.jpg" name="Default On Loading Error" />
      </Col>
    </Row>,
  ));
