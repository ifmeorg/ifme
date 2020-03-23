import React from 'react';
import { storiesOf } from '@storybook/react';
import photoTara from '../../../app/assets/images/contributors/tara_swenson.jpg';
import { Avatar } from '../components/Avatar';

const name = 'Tara';

storiesOf('Avatar', module)
  .add('With image', () => (
    <>
      <Avatar src={photoTara} small />
      <br />
      <Avatar src={photoTara} />
      <br />
      <Avatar src={photoTara} large />
    </>
  ))
  .add('Without image', () => (
    <>
      <Avatar small />
      <br />
      <Avatar />
      <br />
      <Avatar large />
    </>
  ))
  .add('With image and name', () => (
    <>
      <Avatar src={photoTara} name={name} small />
      <br />
      <Avatar src={photoTara} name={name} />
      <br />
      <Avatar src={photoTara} name={name} large />
    </>
  ))
  .add('Without image and with name', () => (
    <>
      <Avatar small name={name} />
      <br />
      <Avatar name={name} />
      <br />
      <Avatar name={name} large />
    </>
  ));
