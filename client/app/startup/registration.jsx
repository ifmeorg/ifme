// @flow
/**
 * Add components only if needed in current _if me_ application, because
 * this bundle will be loaded in production.
 */

import jstz from 'jstimezonedetect';
import ReactOnRails from 'react-on-rails';
import { loadLocales } from '../libs/i18n/I18nSetup';
import '../styles/_global.scss';
import { Avatar } from '../components/Avatar';
import { Chart } from '../components/Chart';
import { ChartControl } from '../components/Chart/ChartControl';
import { Header } from '../components/Header';
import { Resource } from '../components/Resource';
import { Tag } from '../components/Tag';
import { Logo } from '../components/Logo';
import { Story } from '../components/Story';
import { Tooltip } from '../components/Tooltip';
import { Resources } from '../widgets/Resources';

window.jstz = jstz;
loadLocales();

// This is how react_on_rails can see the Components in the browser.
ReactOnRails.register({
  Avatar,
  Chart,
  ChartControl,
  Header,
  Logo,
  Resource,
  Resources,
  Story,
  Tag,
  Tooltip,
});
