// @flow
import ReactOnRails from 'react-on-rails';

import Chart from '../components/Chart';
import ChartControl from '../components/ChartControl';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  Chart,
  ChartControl,
});
