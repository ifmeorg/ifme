import React from 'react';
import { Accordion } from '../components/Accordion';
import { mulberry } from '../../.storybook/backgrounds';

const title = 'Accordions have pianos';
const children = 'Hello';

export default {
  title: 'Components/Accordion',
};

export const Default = () => (
  <Accordion id="some_id" title={title}>
    {children}
  </Accordion>
);

Default.story = {
  name: 'Default size and style',
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
  },
};

export const DefaultLarge = () => (
  <Accordion id="some_id" title={title} large>
    {children}
  </Accordion>
);

DefaultLarge.story = {
  name: 'Default style and large size',
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
  },
};

export const DefaultDark = () => (
  <Accordion id="some_id" title={title} dark>
    {children}
  </Accordion>
);

DefaultDark.story = {
  name: 'Default size and dark style',
};

export const LargeDark = () => (
  <Accordion id="some_id" title={title} large dark>
    {children}
  </Accordion>
);

LargeDark.story = {
  name: 'Large size and dark style',
};
