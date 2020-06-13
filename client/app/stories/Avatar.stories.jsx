import React from 'react';
import photoTara from '../../../app/assets/images/contributors/tara_swenson.jpg';
import { Avatar } from '../components/Avatar';

const name = 'Tara';

export default {
  title: 'Components/Avatar',
};

export const WithImage = () => (
  <>
    <Avatar src={photoTara} small />
    <br />
    <Avatar src={photoTara} />
    <br />
    <Avatar src={photoTara} large />
  </>
);

WithImage.story = {
  name: 'With image',
};

export const WithoutImage = () => (
  <>
    <Avatar small />
    <br />
    <Avatar />
    <br />
    <Avatar large />
  </>
);

WithoutImage.story = {
  name: 'Without image',
};

export const WithImageAndName = () => (
  <>
    <Avatar src={photoTara} name={name} small />
    <br />
    <Avatar src={photoTara} name={name} />
    <br />
    <Avatar src={photoTara} name={name} large />
  </>
);

WithImageAndName.story = {
  name: 'With image and name',
};

export const WithoutImageAndWithName = () => (
  <>
    <Avatar small name={name} />
    <br />
    <Avatar name={name} />
    <br />
    <Avatar name={name} large />
  </>
);

WithoutImageAndWithName.story = {
  name: 'Without image and with name',
};
