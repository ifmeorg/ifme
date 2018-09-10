import React from 'react';
import { storiesOf } from '@storybook/react';
import { Logo, LogoSolid } from '../components/Logo';

const link = 'http://if-me.org';

storiesOf('Logo', module)
  .add('Small', () => <Logo sm />)
  .add('Small with link', () => <Logo sm link={link} />)
  .add('Regular', () => <Logo />)
  .add('Regular with link', () => <Logo link={link} />)
  .add('Large', () => <Logo lg />)
  .add('Large with link', () => <Logo lg link={link} />)
  .add('Solid small', () => <LogoSolid sm />)
  .add('Solid small with link', () => <LogoSolid sm link={link} />)
  .add('Solid regular', () => <LogoSolid />)
  .add('Solid regular with link', () => <LogoSolid link={link} />)
  .add('Solid large', () => <LogoSolid lg />)
  .add('Solid large with link', () => <LogoSolid lg link={link} />);
