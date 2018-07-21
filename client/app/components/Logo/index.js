// @flow
import { LogoFactory } from './LogoFactory';

export const Logo = LogoFactory();
Logo.displayName = 'Logo';

export const LogoSmall = LogoFactory('small');
LogoSmall.displayName = 'LogoSmall';
