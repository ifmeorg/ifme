import 'chartjs';
import React from 'react';

import { storiesOf } from '@storybook/react';

import Chart from '../bundles/momentDashboards/components/Chart';
import ChartControl from '../bundles/momentDashboards/components/ChartControl';

import Logo from '../bundles/shared/components/Logo';
import Input from '../bundles/shared/components/Input';
import Button from '../bundles/shared/components/Button';
import SideNav from '../bundles/shared/components/SideNav';


    storiesOf('SideNav', module)
    .add('SideNav-Purple', () => (
      <SideNav color="purple"></SideNav>
    ))
    .add('SideNav-Silver', () => (
      <SideNav color="silver"></SideNav>
    ));