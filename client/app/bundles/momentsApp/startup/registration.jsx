// @flow
import ReactOnRails from 'react-on-rails';

import Chart, { ChartControl } from '../components/Chart';

// This is how react_on_rails can see the Components in the browser.
ReactOnRails.register({
  Chart,
  ChartControl,
});
