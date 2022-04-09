/* eslint-disable no-unused-vars */
/* eslint-disable max-len */
import React from 'react';
import { Tooltip } from 'components/Tooltip';
import { Logo } from 'components/Logo';

const longText = 'Heya this is a tooltip with a lot of fun text. Blah blah blah. Hover boards!';
const shortText = 'Heya this is a tooltip.';

export default {
  title: 'Components/Tooltip',
};

const ElementIsTextTemplate = (args) => (
  <center>
    <Tooltip element="Hello" text={longText} />
    <br />
    <br />
    <Tooltip element="Hello another thing" text={shortText} />
  </center>
);

export const ElementIsText = ElementIsTextTemplate.bind({});

ElementIsText.storyName = 'Element is text';

const ElementIsHtmlTemplate = (args) => (
  <center>
    <Tooltip element={<Logo lg />} text={longText} />
    <br />
    <br />
    <Tooltip element={<Logo lg />} text={shortText} />
  </center>
);

export const ElementIsHtml = ElementIsHtmlTemplate.bind({});

ElementIsHtml.storyName = 'Element is HTML';
ElementIsHtml.parameters = {
  backgrounds: { default: 'mulberry' },
};

const ElementIsTextAndTooltipIsPositionedRightTemplate = (args) => (
  <center>
    <Tooltip element="Hello" text={longText} right />
    <br />
    <br />
    <Tooltip element="Hello another thing" text={shortText} right />
  </center>
);

export const ElementIsTextAndTooltipIsPositionedRight = ElementIsTextAndTooltipIsPositionedRightTemplate.bind({});

ElementIsTextAndTooltipIsPositionedRight.storyName = 'Element is text and tooltip is positioned right';

const ElementIsHtmlAndTooltipIsPositionedRightTemplate = (args) => (
  <center>
    <Tooltip element={<Logo lg />} text={longText} right />
    <br />
    <br />
    <Tooltip element={<Logo lg />} text={shortText} right />
  </center>
);

export const ElementIsHtmlAndTooltipIsPositionedRight = ElementIsHtmlAndTooltipIsPositionedRightTemplate.bind({});

ElementIsHtmlAndTooltipIsPositionedRight.storyName = 'Element is HTML and tooltip is positioned right';
ElementIsHtmlAndTooltipIsPositionedRight.parameters = {
  backgrounds: { default: 'mulberry' },
};

const ElementIsTextAndTooltipIsPositionedCenterTemplate = (args) => (
  <center>
    <Tooltip element="Hello" text={longText} center />
    <br />
    <br />
    <Tooltip element="Hello another thing" text={shortText} center />
  </center>
);

export const ElementIsTextAndTooltipIsPositionedCenter = ElementIsTextAndTooltipIsPositionedCenterTemplate.bind({});

ElementIsTextAndTooltipIsPositionedCenter.storyName = 'Element is text and tooltip is positioned center';

const ElementIsHtmlAndTooltipIsPositionedCenterTemplate = (args) => (
  <center>
    <Tooltip element={<Logo lg />} text={longText} center />
    <br />
    <br />
    <Tooltip element={<Logo lg />} text={shortText} center />
  </center>
);

export const ElementIsHtmlAndTooltipIsPositionedCenter = ElementIsHtmlAndTooltipIsPositionedCenterTemplate.bind({});

ElementIsHtmlAndTooltipIsPositionedCenter.storyName = 'Element is HTML and tooltip is positioned center';
ElementIsHtmlAndTooltipIsPositionedCenter.parameters = {
  backgrounds: { default: 'mulberry' },
};
