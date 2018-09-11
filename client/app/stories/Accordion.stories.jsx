import React from 'react';
import { storiesOf } from '@storybook/react';
import { Accordion } from '../components/Accordion';

storiesOf('Accordion', module).add('Without name', () => (
  <div>
    <Accordion title="Accordions have pianos">
      <strong>Hello</strong>
    </Accordion>
    <Accordion title="Accordions have pianos" large>
      <strong>Hello</strong>
    </Accordion>
    <Accordion title="Accordions have pianos" dark>
      <strong>Hello</strong>
    </Accordion>
    <Accordion title="Accordions have pianos" dark large>
      <strong>Hello</strong>
    </Accordion>
  </div>
));
