import React from 'react';
import { OAuthButton } from 'components/OAuthButton';

export default {
  title: 'Components/OAuthButton',
};

export const SignInWithGoogle = () => (
  <OAuthButton
    signIn
    type="google"
    token="token"
    action="/fake-action"
  />
);

SignInWithGoogle.story = {
  name: 'Sign in with Google',
};

export const SignUpWithGoogle = () => (
  <OAuthButton type="google" token="token" action="/fake-action" />
);

SignUpWithGoogle.story = {
  name: 'Sign up with Google',
};

export const SignInWithFacebook = () => (
  <OAuthButton
    signIn
    type="facebook"
    token="token"
    action="/fake-action"
  />
);

SignInWithFacebook.story = {
  name: 'Sign in with Facebook',
};

export const SignUpWithFacebook = () => (
  <OAuthButton type="facebook" token="token" action="/fake-action" />
);

SignUpWithFacebook.story = {
  name: 'Sign up with Facebook',
};
