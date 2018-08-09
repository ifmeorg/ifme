// @flow
import { LogoFactory } from './LogoFactory';

export const Logo = LogoFactory();
Logo.displayName = 'Logo';

export const LogoSolid = LogoFactory('solid');
LogoSolid.displayName = 'LogoSolid';
