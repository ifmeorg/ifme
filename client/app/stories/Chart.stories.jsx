/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { Chart } from 'components/Chart';
import { ChartControl } from 'components/Chart/ChartControl';

const sampleChartData = {
  '2013-02-10 00:00:00 -0800': 11,
  '2013-02-11 00:00:00 -0800': 6,
};

export default {
  title: 'Components/Chart',
  parameters: {
    backgrounds: { default: 'white' },
  },
};

const ChartTemplate = (args) => <Chart {...args} />;

export const ChartDisplayWithAreaType = ChartTemplate.bind({});

ChartDisplayWithAreaType.args = { title: 'Sample', data: sampleChartData, chartType: 'Area' };
ChartDisplayWithAreaType.storyName = 'ChartDisplay with area type';

export const ChartDisplayWithLineType = ChartTemplate.bind({});

ChartDisplayWithLineType.args = { title: 'Sample', data: sampleChartData, chartType: 'Line' };
ChartDisplayWithLineType.storyName = 'ChartDisplay with line type';

const ChartControlTemplate = (args) => <ChartControl {...args} />;

export const MyChartControl = ChartControlTemplate.bind({});

MyChartControl.args = {
  types: ['Moments', 'Categories', 'Moods'],
  initialParams: {
    type: 'Categories',
    data: {
      Categories: [
        {
          name: 'School',
          data: { '2013-02-10': 2, '2013-02-11': 4, '2013-02-12': 50 },
        },
        {
          name: 'Job',
          data: { '2013-02-10': 11, '2013-02-11': 6, '2013-02-12': 15 },
        },
        {
          name: 'Relationship',
          data: { '2013-02-10': 5, '2013-02-11': 6, '2013-02-12': 5 },
        },
      ],
      Moods: [
        {
          name: 'Anxious',
          data: { '2013-02-10': 5, '2013-02-11': 12, '2013-02-12': 1 },
        },
        {
          name: 'Shy',
          data: { '2013-02-10': 10, '2013-02-11': 16, '2013-02-12': 15 },
        },
      ],
      Moments: { '2013-02-10': 10, '2013-02-11': 16, '2013-02-12': 2 },
    },
  },
};
MyChartControl.storyName = 'ChartControl';
