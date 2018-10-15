import React from 'react';
import { storiesOf } from '@storybook/react';
import { SideNav } from '../components/SideNav/index';

storiesOf('SideNav', module)
  .add('SideNav-Silver', () => <SideNav color="silver" />);
