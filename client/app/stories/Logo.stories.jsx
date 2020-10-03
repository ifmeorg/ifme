import React from 'react';
import { Logo, LogoSolid } from 'components/Logo';

const link = 'http://if-me.org';

export default {
  title: 'Components/Logo',
};

export const Small = () => <Logo sm />;

Small.parameters = {
  backgrounds: { default: 'mulberry' },
};

export const SmallWithLink = () => <Logo sm link={link} />;

SmallWithLink.story = {
  name: 'Small with link',
};

SmallWithLink.parameters = {
  backgrounds: { default: 'mulberry' },
};

export const Regular = () => <Logo />;

Regular.parameters = {
  backgrounds: { default: 'mulberry' },
};

export const RegularWithLink = () => <Logo link={link} />;

RegularWithLink.story = {
  name: 'Regular with link',
};

RegularWithLink.parameters = {
  backgrounds: { default: 'mulberry' },
};

export const Large = () => <Logo lg />;

Large.parameters = {
  backgrounds: { default: 'mulberry' },
};

export const LargeWithLink = () => <Logo lg link={link} />;

LargeWithLink.story = {
  name: 'Large with link',
};

LargeWithLink.parameters = {
  backgrounds: { default: 'mulberry' },
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
