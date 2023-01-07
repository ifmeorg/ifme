// @flow
/**
 * Add components only if needed in current application, because
 * this bundle will be loaded in production.
 */
import ReactOnRails from 'react-on-rails';
import 'styles/_global.scss';
import { Accordion } from 'components/Accordion';
import { Avatar } from 'components/Avatar';
import BaseContainer from 'components/BaseContainer';
import { Chart } from 'components/Chart';
import { ChartControl } from 'components/Chart/ChartControl';
import Header from 'components/Header';
import Form from 'components/Form';
import { HeaderProfile } from 'components/Header/HeaderProfile';
import { Logo } from 'components/Logo';
import Modal from 'components/Modal';
import { Resource } from 'components/Resource';
import SkipToContent from 'components/SkipToContent';
import { Story } from 'components/Story';
import { StoryDraft } from 'components/Story/StoryDraft';
import { StoryActions } from 'components/Story/StoryActions';
import { StoryCategories } from 'components/Story/StoryCategories';
import { StoryMoods } from 'components/Story/StoryMoods';
import { StoryDate } from 'components/Story/StoryDate';
import { Tag } from 'components/Tag';
import { Tooltip } from 'components/Tooltip';
import Input from 'components/Input';
import OAuthButton from 'components/OAuthButton';
import Toast from 'components/Toast';
import Comments from 'widgets/Comments';
import { ToggleLocale } from 'widgets/ToggleLocale';
import Resources from 'widgets/Resources';
import { Notifications } from 'widgets/Notifications';
import CrisisPrevention from 'widgets/CrisisPrevention';
import CarePlanContacts from 'widgets/CarePlanContacts';
import MomentTemplates from 'pages/MomentTemplates';
import { scrollToTop } from './scrollToTop';

scrollToTop();

// This is how react_on_rails can see the Components in the browser.
ReactOnRails.register({
  Accordion,
  Avatar,
  BaseContainer,
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
  SkipToContent,
  Story,
  StoryActions,
  StoryCategories,
  StoryDate,
  StoryDraft,
  StoryMoods,
  Tag,
  ToggleLocale,
  Tooltip,
  Toast,
  CrisisPrevention,
  CarePlanContacts,
  OAuthButton,
  MomentTemplates,
});
