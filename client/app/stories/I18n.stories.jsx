import React from 'react';
import { storiesOf } from '@storybook/react';
import { I18n } from '../libs/i18n';

storiesOf('I18n', module).add('Message with variable', () => (
  <div>
    <h1>{I18n.t('created', { created_at: 'Blah' })}</h1>
    <p>{I18n.t('draft')}</p>
  </div>
));
