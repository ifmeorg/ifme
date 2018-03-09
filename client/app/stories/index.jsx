import 'chartjs';
import React from 'react';

import { storiesOf } from '@storybook/react';

import Chart from '../bundles/momentDashboards/components/Chart';
import ChartControl from '../bundles/momentDashboards/components/ChartControl';

import Logo from '../bundles/shared/components/Logo';
import Input from '../bundles/shared/components/Input';
import Textarea from '../bundles/shared/components/Textarea';
import DropdownGhost from '../bundles/shared/components/Dropdown/DropdownGhost';
import DropdownGhostSmall from '../bundles/shared/components/Dropdown/DropdownGhostSmall';
import DropdownFillSmall from '../bundles/shared/components/Dropdown/DropdownFillSmall';
import Footer from '../bundles/shared/components/Footer/Footer';
import Resources from '../bundles/shared/components/Resource/Resources';
import Tag from '../bundles/shared/components/Tag';

const taggedResources = {
  name: 'LifeSIGNS: Self Injury Guidance & Network Support (UK)',
  link: 'http://www.lifesigns.org.uk/',
  tags: ['open_source', 'tech_industry', 'free', 'workplace', 'podcast', 'books'],
};

const externalResources = {
  name: 'Invisible Illnesses: depression is an ocean',
  link: 'www.if-me.org',
  author: 'Desi Rottman',
};

storiesOf('Resources', module)
  .add('Tagged Resources', () => (
    <div style={{ backgroundColor: '#000' }}>
      <Resources
        tagged
        resourcesObj={taggedResources}
      />
    </div>
  ))
  .add('External Resources', () => (
    <div style={{ backgroundColor: '#000' }}>
      <Resources
        resourcesObj={externalResources}
      />
    </div>
  ));

storiesOf('Tags', module)
  .add('TagGhostXs', () => (
    <Tag label={'Self-Injury'} />
  ))
  .add('TagDarkXs', () => (
    <Tag dark label={'Self-Injury'} />
  ))
  .add('Tag', () => (
    <Tag normal label={'Self-Injury'} />
  ));


storiesOf('Logo', module)
  .add('Small', () => (
    <Logo size="small" />
  ))
  .add('Medium', () => (
    <Logo />
  ));

const sampleChartData = { '2013-02-10 00:00:00 -0800': 11, '2013-02-11 00:00:00 -0800': 6 };

storiesOf('Chart', module)
  .add('Chart Display Area', () => (
    <Chart title="Sample" data={sampleChartData} chartType="Area" />
  ))
  .add('Chart Display Line', () => (
    <Chart title="Sample" data={sampleChartData} chartType="Line" />
  ))
  .add('Chart Control', () => (
    <ChartControl
      types={['Moments', 'Categories', 'Moods']}
      initialParams={{
        type: 'Categories',
        data: {
          Categories: [
            { name: 'School', data: { '2013-02-10': 2, '2013-02-11': 4, '2013-02-12': 50 } },
            { name: 'Job', data: { '2013-02-10': 11, '2013-02-11': 6, '2013-02-12': 15 } },
            { name: 'Relationship', data: { '2013-02-10': 5, '2013-02-11': 6, '2013-02-12': 5 } },
          ],
          Moods: [
            { name: 'Anxious', data: { '2013-02-10': 5, '2013-02-11': 12, '2013-02-12': 1 } },
            { name: 'Shy', data: { '2013-02-10': 10, '2013-02-11': 16, '2013-02-12': 15 } },
          ],
          Moments: { '2013-02-10': 10, '2013-02-11': 16, '2013-02-12': 2 },
        },
      }}
    />
  ));

storiesOf('Input', module)
  .add('Input Light', () => (
    <Input label="Hello" placeholder="Placeholder" />
  ))
  .add('Input Dark', () => (
    <Input dark label="Hello" placeholder="Placeholder" />
  ))
  .add('Input Light (Large)', () => (
    <Input large label="Hello" placeholder="Placeholder" />
  ))
  .add('Input Dark (Large)', () => (
    <Input dark large label="Hello" placeholder="Placeholder" />
  ));

storiesOf('Textarea', module)
  .add('Textarea', () => (
    <Textarea rows={6} label="What happened and how do you feel?" placeholder="I felt..." />
  ));

storiesOf('Dropdown', module)
  .add('DropdownGhost', () => (
    <DropdownGhost />
  ))
  .add('DropdownGhostSmall', () => (
    <DropdownGhostSmall />
  ))
  .add('DropdownFillSmall', () => (
    <DropdownFillSmall />
  ));

storiesOf('Footer', module)
  .add('View', () => (
    <Footer />
  ));

