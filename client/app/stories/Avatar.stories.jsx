import React from 'react';
import { Avatar } from 'components/Avatar';
/* eslint-disable import/no-extraneous-dependencies */
import photo from 'app/assets/images/contributors/ingrid_garcia.jpg';

const name = 'Tara';

export default {
  title: 'Components/Avatar',
};

export const WithImage = () => (
  <>
    <Avatar src={photo} small />
    <br />
    <Avatar src={photo} />
    <br />
    <Avatar src={photo} large />
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
    <Avatar src={photo} name={name} small />
    <br />
    <Avatar src={photo} name={name} />
    <br />
    <Avatar src={photo} name={name} large />
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
