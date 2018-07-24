import React from 'react';
import { action } from '@storybook/addon-actions';
import { storiesOf } from '@storybook/react';
import { Textarea } from '../components/Textarea';

/**
 * TODO: Need to fix event handlers in the Textarea component because the implementation
 * currently ignores them.
 */
storiesOf('Textarea', module).add('Textarea', () => (
  <Textarea
    rows={6}
    label="What happened and how do you feel?"
    placeholder="I felt..."
    onBlur={action('Textarea.onBlur')}
    onChange={action('Textarea.onChange')}
    onFocus={action('Textarea.onFocus')}
  />
));
