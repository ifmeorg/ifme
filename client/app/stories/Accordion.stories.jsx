import React from 'react';
import { storiesOf } from '@storybook/react';
import { Accordion } from '../components/Accordion';

const title = 'Accordions have pianos';
const children = <strong>Hello</strong>;

storiesOf('Accordion', module).add('Accordion', () => (
  <div>
    <Accordion id="some_id" title={title}>
      {children}
    </Accordion>
    <Accordion id="some_id" title={title} large>
      {children}
    </Accordion>
    <Accordion id="some_id" title={title} dark>
      {children}
    </Accordion>
    <Accordion id="some_id" title={title} dark large>
      {<strong>Hello</strong>}
    </Accordion>
  </div>
));
