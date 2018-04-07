import { Col, Row } from 'antd';
import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import Resource from '../bundles/shared/components/Resource';

const withSource = el => withInfo()(() => el);
const tags = ['open_source', 'tech_industry', 'free', 'workplace', 'podcast', 'books'];

storiesOf('Resource', module)
  .add('Tagged Resource', withSource(
    <Row gutter={24} style={{ backgroundColor: '#6D0839', padding: '24px' }}>
      <Col span={8}>
        <Resource
          tagged
          tags={[]}
          title={'LifeSIGNS: Self Injury Guidance & Network Support (UK)'}
          link={'http://www.lifesigns.org.uk/'}
        />
      </Col>
      <Col span={8}>
        <Resource
          tagged
          tags={tags}
          title={'LifeSIGNS: Self Injury Guidance & Network Support (UK)'}
          link={'http://www.lifesigns.org.uk/'}
        />
      </Col>
      <Col span={8}>
        <Resource
          tagged
          tags={tags.concat(tags)}
          title={'LifeSIGNS: Self Injury Guidance & Network Support (UK)'}
          link={'http://www.lifesigns.org.uk/'}
        />
      </Col>
    </Row>,
  ))

  .add('External Resource', withSource(
    <Row gutter={24} style={{ backgroundColor: '#6D0839', padding: '24px' }}>
      <Col span={8}>
        <Resource
          external
          title={'Invisible Illnesses: depression is an ocean'}
          link={'www.if-me.org'}
        />
      </Col>
      <Col span={8}>
        <Resource
          external
          title={'Invisible Illnesses: depression is an ocean'}
          link={'www.if-me.org'}
          author={'Desi Rottman'}
        />
      </Col>
      <Col span={8}>
        <Resource
          external
          title={'A very long title for a resource that should wrap to two lines and then some or not'}
          link={'www.if-me.org'}
          author={'Author with a very very long name that is usually an edge case'}
        />
      </Col>
    </Row>,
  ))

  .add('Combination Resource', withSource(
    <Row gutter={24} style={{ backgroundColor: '#6D0839', padding: '24px' }}>
      <Col span={8}>
        <Resource
          tagged
          external
          tags={[]}
          title={'Invisible Illnesses: depression is an ocean'}
          link={'www.if-me.org'}
          author={'Desi Rottman'}
        />
      </Col>
      <Col span={8}>
        <Resource
          tagged
          external
          tags={tags}
          title={'Invisible Illnesses: depression is an ocean'}
          link={'www.if-me.org'}
          author={'Desi Rottman'}
        />
      </Col>
      <Col span={8}>
        <Resource
          tagged
          external
          tags={tags.concat(tags)}
          title={'Invisible Illnesses: depression is an ocean, and another measure to consider'}
          link={'www.if-me.org'}
          author={'Desi Rottman'}
        />
      </Col>
    </Row>,
  ));
