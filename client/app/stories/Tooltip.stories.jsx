import React from 'react';
import { storiesOf } from '@storybook/react';
import { Tooltip } from '../components/Tooltip';
import { Logo } from '../components/Logo';

const longText = 'Heya this is a tooltip with a lot of fun text. Blah blah blah. Hover boards!';
const shortText = 'Heya this is a tooltip.';

storiesOf('Tooltip', module)
  .add('Element is text', () => (
    <div>
      <Tooltip element="Hello" text={longText} />
      <br /><br /><Tooltip element="Hello another thing" text={shortText} />
    </div>
  ))
  .add('Element is HTML', () => (
    <div>
      <Tooltip element={<Logo lg />} text={longText} />
      <br /><br /><Tooltip element={<Logo lg />} text={shortText} />
    </div>
  ))
  .add('Element is text and tooltip is positioned right', () => (
    <div>
      <Tooltip element="Hello" text={longText} right />
      <br /><br /><Tooltip element="Hello another thing" text={shortText} right />
    </div>
  ))
  .add('Element is HTML and tooltip is positioned right', () => (
    <div>
      <Tooltip element={<Logo lg />} text={longText} right />
      <br /><br /><Tooltip element={<Logo lg />} text={shortText} right />
    </div>
  ));
