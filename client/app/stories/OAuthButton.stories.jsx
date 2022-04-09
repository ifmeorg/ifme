/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { OAuthButton } from 'components/OAuthButton';

export default {
  title: 'Components/OAuthButton',
  component: OAuthButton,
};

const Template = (args) => <OAuthButton {...args} />;

export const SignInWithGoogle = Template.bind({});

SignInWithGoogle.args = {
  signIn: true,
  type: 'google',
  token: 'token',
  action: '/fake-action',
};
SignInWithGoogle.storyName = 'Sign in with Google';

export const SignUpWithGoogle = Template.bind({});

SignUpWithGoogle.args = {
  type: 'google',
  token: 'token',
  action: '/fake-action',
};
SignUpWithGoogle.storyName = 'Sign up with Google';

export const SignInWithFacebook = Template.bind({});

SignInWithFacebook.args = {
  signIn: true,
  type: 'facebook',
  token: 'token',
  action: '/fake-action',
};
SignInWithFacebook.storyName = 'Sign in with Facebook';

export const SignUpWithFacebook = Template.bind({});

SignUpWithFacebook.args = {
  type: 'facebook',
  token: 'token',
  action: '/fake-action',
};
SignUpWithFacebook.storyName = 'Sign up with Facebook';
