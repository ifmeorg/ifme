import React from 'react';
import { Tooltip } from '../components/Tooltip';
import { Logo } from '../components/Logo';
import { mulberry } from '../../.storybook/backgrounds';

const longText = 'Heya this is a tooltip with a lot of fun text. Blah blah blah. Hover boards!';
const shortText = 'Heya this is a tooltip.';

export default {
  title: 'Components/Tooltip',
};

export const ElementIsText = () => (
  <center>
    <Tooltip element="Hello" text={longText} />
    <br />
    <br />
    <Tooltip element="Hello another thing" text={shortText} />
  </center>
);

ElementIsText.story = {
  name: 'Element is text',
};

export const ElementIsHtml = () => (
  <center>
    <Tooltip element={<Logo lg />} text={longText} />
    <br />
    <br />
    <Tooltip element={<Logo lg />} text={shortText} />
  </center>
);

ElementIsHtml.story = {
  name: 'Element is HTML',
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
  },
};

export const ElementIsTextAndTooltipIsPositionedRight = () => (
  <center>
    <Tooltip element="Hello" text={longText} right />
    <br />
    <br />
    <Tooltip element="Hello another thing" text={shortText} right />
  </center>
);

ElementIsTextAndTooltipIsPositionedRight.story = {
  name: 'Element is text and tooltip is positioned right',
};

export const ElementIsHtmlAndTooltipIsPositionedRight = () => (
  <center>
    <Tooltip element={<Logo lg />} text={longText} right />
    <br />
    <br />
    <Tooltip element={<Logo lg />} text={shortText} right />
  </center>
);

ElementIsHtmlAndTooltipIsPositionedRight.story = {
  name: 'Element is HTML and tooltip is positioned right',
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
  },
};

export const ElementIsTextAndTooltipIsPositionedCenter = () => (
  <center>
    <Tooltip element="Hello" text={longText} center />
    <br />
    <br />
    <Tooltip element="Hello another thing" text={shortText} center />
  </center>
);

ElementIsTextAndTooltipIsPositionedCenter.story = {
  name: 'Element is text and tooltip is positioned center',
};

export const ElementIsHtmlAndTooltipIsPositionedCenter = () => (
  <center>
    <Tooltip element={<Logo lg />} text={longText} center />
    <br />
    <br />
    <Tooltip element={<Logo lg />} text={shortText} center />
  </center>
);

ElementIsHtmlAndTooltipIsPositionedCenter.story = {
  name: 'Element is HTML and tooltip is positioned center',
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
  },
};
