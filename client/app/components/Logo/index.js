// @flow
import { LogoFactory } from './LogoFactory';

export const Logo: any = LogoFactory();
Logo.displayName = 'Logo';

export const LogoSolid: any = LogoFactory('solid');
LogoSolid.displayName = 'LogoSolid';
