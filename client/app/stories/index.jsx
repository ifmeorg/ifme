import 'chartjs';
import React from 'react';

import { storiesOf } from '@storybook/react';

import Chart from '../bundles/momentDashboards/components/Chart';
import ChartControl from '../bundles/momentDashboards/components/ChartControl';

import Logo from '../bundles/shared/components/Logo';
import Input from '../bundles/shared/components/Input';

import ButtonFilled from '../bundles/buttons/ButtonFilled';
import ButtonFilledM from '../bundles/buttons/ButtonFilledM';
import ButtonGhost from '../bundles/buttons/ButtonGhost';
import ButtonGhostM from '../bundles/buttons/ButtonGhostM';
import ButtonGhostXS from '../bundles/buttons/ButtonGhostXS';

storiesOf('Logo', module)
  .add('Small', () => (
    <Logo size="small" />
  ))
  .add('Medium', () => (
    <Logo />
  ))

storiesOf('Buttons', module)
.add('ButtonFilled', () => (
    <ButtonFilled text="Join"></ButtonFilled>
  ))
.add('ButtonFilledM', () => (
    <ButtonFilledM text="Join"></ButtonFilledM>
  ))
.add('ButtonGhost', () => (
    <ButtonGhost text="Join"></ButtonGhost>
  ))
.add('ButtonGhostM', () => (
    <ButtonGhostM text="Join"></ButtonGhostM>
  ))
.add('ButtonGhostXS', () => (
    <ButtonGhostXS text="Join"></ButtonGhostXS>
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
    <Input label="Hello" placeholder="Placeholder"/>
  ))
  .add('Input Dark', () => (
    <Input dark label="Hello" placeholder="Placeholder" />
  ))
  .add('Input Light (Large)', () => (
    <Input large label="Hello" placeholder="Placeholder"/>
  ))
  .add('Input Dark (Large)', () => (
    <Input dark large label="Hello" placeholder="Placeholder" />
  ));
