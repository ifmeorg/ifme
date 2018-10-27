// @flow
/**
 * Add components only if needed in current application, because
 * this bundle will be loaded in production.
 */
import ReactOnRails from 'react-on-rails';
import { scrollToTop } from './scrollToTop';
import '../styles/_global.scss';
import { Avatar } from '../components/Avatar';
import { Chart } from '../components/Chart';
import { ChartControl } from '../components/Chart/ChartControl';
import { Header } from '../components/Header';
import { HeaderProfile } from '../components/Header/HeaderProfile';
import { Resource } from '../components/Resource';
import { Tag } from '../components/Tag';
import { Logo } from '../components/Logo';
import { Story } from '../components/Story';
import { StoryDraft } from '../components/Story/StoryDraft';
import { StoryActions } from '../components/Story/StoryActions';
import { StoryCategories } from '../components/Story/StoryCategories';
import { StoryMoods } from '../components/Story/StoryMoods';
import { StoryDate } from '../components/Story/StoryDate';
import { Tooltip } from '../components/Tooltip';
import { Modal } from '../components/Modal';
import { Form } from '../components/Form';
import { Accordion } from '../components/Accordion';
import { Resources } from '../widgets/Resources';
import { Notifications } from '../widgets/Notifications';
import { ToggleLocale } from '../widgets/ToggleLocale';
import { Comments } from '../widgets/Comments';

scrollToTop();

// This is how react_on_rails can see the Components in the browser.
ReactOnRails.register({
  Avatar,
  Accordion,
  Chart,
  ChartControl,
  Comments,
  Form,
  Header,
  HeaderProfile,
  Logo,
  Modal,
  Notifications,
  Resource,
  Resources,
  Story,
  StoryActions,
  StoryCategories,
  StoryDate,
  StoryDraft,
  StoryMoods,
  Tag,
  ToggleLocale,
  Tooltip,
});
