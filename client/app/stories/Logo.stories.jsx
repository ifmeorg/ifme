/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { Logo, LogoSolid } from 'components/Logo';

const link = 'http://if-me.org';

export default {
  title: 'Components/Logo',
};

const LogoTemplate = (args) => <Logo {...args} />;

export const RegularStyleAndSmallSize = LogoTemplate.bind({});

RegularStyleAndSmallSize.args = { sm: true };
RegularStyleAndSmallSize.parameters = {
  backgrounds: { default: 'mulberry' },
};
RegularStyleAndSmallSize.storyName = 'Regular style and small size';

export const RegularStyleAndSmallSizeWithLink = LogoTemplate.bind({});

RegularStyleAndSmallSizeWithLink.args = { sm: true, link };
RegularStyleAndSmallSizeWithLink.storyName = 'Regular style and small size with link';
RegularStyleAndSmallSizeWithLink.parameters = {
  backgrounds: { default: 'mulberry' },
};

export const RegularStyleAndRegularSize = LogoTemplate.bind({});

RegularStyleAndRegularSize.parameters = {
  backgrounds: { default: 'mulberry' },
};
RegularStyleAndRegularSize.storyName = 'Regular style and regular size';

export const RegularStyleAndRegularSizeWithLink = LogoTemplate.bind({});

RegularStyleAndRegularSizeWithLink.args = { link };
RegularStyleAndRegularSizeWithLink.storyName = 'Regular style and regular size with link';
RegularStyleAndRegularSizeWithLink.parameters = {
  backgrounds: { default: 'mulberry' },
};

export const RegularStyleAndLargeSize = LogoTemplate.bind({});

RegularStyleAndLargeSize.args = { lg: true };
RegularStyleAndLargeSize.parameters = {
  backgrounds: { default: 'mulberry' },
};
RegularStyleAndLargeSize.storyName = 'Regular style and large size';

export const RegularStyleAndLargeSizeWithLink = LogoTemplate.bind({});

RegularStyleAndLargeSizeWithLink.args = { lg: true, link };
RegularStyleAndLargeSizeWithLink.storyName = 'Regular style and large size with link';
RegularStyleAndLargeSizeWithLink.parameters = {
  backgrounds: { default: 'mulberry' },
};

const LogoSolidTemplate = (args) => <LogoSolid {...args} />;

export const SolidStyleAndSmallSize = LogoSolidTemplate.bind({});

SolidStyleAndSmallSize.args = { sm: true };
SolidStyleAndSmallSize.storyName = 'Solid style and small size';

export const SolidStyleAndSmallSizeWithLink = LogoSolidTemplate.bind({});

SolidStyleAndSmallSizeWithLink.args = { sm: true, link };
SolidStyleAndSmallSizeWithLink.storyName = 'Solid style and small size with link';

export const SolidStyleAndRegularSize = LogoSolidTemplate.bind({});

SolidStyleAndRegularSize.storyName = 'Solid style and regular size';

export const SolidStyleAndRegularSizeWithLink = LogoSolidTemplate.bind({});

SolidStyleAndRegularSizeWithLink.args = { link };
SolidStyleAndRegularSizeWithLink.storyName = 'Solid style and regular size with link';

export const SolidStyleAndLargeSize = LogoSolidTemplate.bind({});

SolidStyleAndLargeSize.args = { lg: true };
SolidStyleAndLargeSize.storyName = 'Solid style and large style';

export const SolidStyleAndLargeSizeWithLink = LogoSolidTemplate.bind({});

SolidStyleAndLargeSizeWithLink.args = { lg: true, link };
SolidStyleAndLargeSizeWithLink.storyName = 'Solid style and large size with link';
