import React from 'react';
import { storiesOf } from '@storybook/react';
import photoTara from '../../../app/assets/images/contributors/tara_swenson.jpg';
import { Avatar } from '../components/Avatar';

storiesOf('Avatar', module)
  .add('Without name', () => (
    <Avatar src={photoTara} name="Tara Swenson" />
  ))
  .add('Without name and invalid image', () => (
    <Avatar src="NonExistentFile.jpg" name="Default On Loading Error" />
  ))
  .add('With name', () => (
    <Avatar src={photoTara} name="Tara Swenson" displayName />
  ))
  .add('With name and invalid image', () => (
    <Avatar
      src="NonExistentFile.jpg"
      name="Default On Loading Error"
      displayName
    />
  ));
