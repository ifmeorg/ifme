import React from 'react';
import { storiesOf } from '@storybook/react';
import { Accordion } from '../components/Accordion';

const title = 'Accordions have pianos';
const children = <strong>Hello</strong>;

storiesOf('Accordion', module).add('Accordion', () => (
  <div>
    <Accordion title={title}>{children}</Accordion>
    <Accordion title={title} large>
      {children}
    </Accordion>
    <Accordion title={title} dark>
      {children}
    </Accordion>
    <Accordion title={title} dark large>
      {<strong>Hello</strong>}
    </Accordion>
  </div>
));
