import React from 'react';
import { Logo, LogoSolid } from '../components/Logo';
import { mulberry } from '../../.storybook/backgrounds';

const link = 'http://if-me.org';

export default {
  title: 'Components/Logo',
};

export const Small = () => <Logo sm />;

Small.story = {
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
  },
};

export const SmallWithLink = () => <Logo sm link={link} />;

SmallWithLink.story = {
  name: 'Small with link',
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
  },
};

export const Regular = () => <Logo />;

Regular.story = {
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
  },
};

export const RegularWithLink = () => <Logo link={link} />;

RegularWithLink.story = {
  name: 'Regular with link',
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
  },
};

export const Large = () => <Logo lg />;

Large.story = {
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
  },
};

export const LargeWithLink = () => <Logo lg link={link} />;

LargeWithLink.story = {
  name: 'Large with link',
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
  },
};

export const SolidSmall = () => <LogoSolid sm />;

SolidSmall.story = {
  name: 'Solid small',
};

export const SolidSmallWithLink = () => <LogoSolid sm link={link} />;

SolidSmallWithLink.story = {
  name: 'Solid small with link',
};

export const SolidRegular = () => <LogoSolid />;

SolidRegular.story = {
  name: 'Solid regular',
};

export const SolidRegularWithLink = () => <LogoSolid link={link} />;

SolidRegularWithLink.story = {
  name: 'Solid regular with link',
};

export const SolidLarge = () => <LogoSolid lg />;

SolidLarge.story = {
  name: 'Solid large',
};

export const SolidLargeWithLink = () => <LogoSolid lg link={link} />;

SolidLargeWithLink.story = {
  name: 'Solid large with link',
};
