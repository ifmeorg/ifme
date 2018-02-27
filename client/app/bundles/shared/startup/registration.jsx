// @flow
import ReactOnRails from 'react-on-rails';

import Logo from '../components/Logo';
import Input from '../components/Input';
import Textarea from "../components/Textarea";

// This is how react_on_rails can see the Components in the browser.
ReactOnRails.register({
  Logo,
  Input,
  Textarea
});
