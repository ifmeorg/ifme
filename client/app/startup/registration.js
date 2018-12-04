// @flow
/**
 * Add components only if needed in current application, because
 * this bundle will be loaded in production.
 */
import ReactOnRails from 'react-on-rails';
import { scrollToTop } from './scrollToTop';
import '../styles/_global.scss';
import { Accordion } from '../components/Accordion';
import { Avatar } from '../components/Avatar';
import { Chart } from '../components/Chart';
import { ChartControl } from '../components/Chart/ChartControl';
import { Form } from '../components/Form';
import { Header } from '../components/Header';
import { HeaderProfile } from '../components/Header/HeaderProfile';
import { Logo } from '../components/Logo';
import { Modal } from '../components/Modal';
import { Notifications } from '../widgets/Notifications';
import { Resource } from '../components/Resource';
import { Resources } from '../widgets/Resources';
import { Story } from '../components/Story';
import { StoryDraft } from '../components/Story/StoryDraft';
import { StoryActions } from '../components/Story/StoryActions';
import { StoryCategories } from '../components/Story/StoryCategories';
import { StoryMoods } from '../components/Story/StoryMoods';
import { StoryDate } from '../components/Story/StoryDate';
import { Tag } from '../components/Tag';
import { Tooltip } from '../components/Tooltip';
import { ToggleLocale } from '../widgets/ToggleLocale';
import { Comments } from '../widgets/Comments';
import { Input } from '../components/Input';

scrollToTop();

// This is how react_on_rails can see the Components in the browser.
ReactOnRails.register({
  Accordion,
  Avatar,
  Chart,
  ChartControl,
  Comments,
  Form,
  Header,
  HeaderProfile,
  Input,
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
