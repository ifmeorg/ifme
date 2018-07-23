import React from 'react';
import { FormattedMessage, injectIntl } from 'react-intl';
import { storiesOf } from '@storybook/react';
import { defaultMessages } from '../libs/i18n/default';

const TitleComponent = injectIntl(({ count, intl }) => (
  <h1>
    {intl.formatMessage(defaultMessages.sharedCharacterCount, {
      number: count,
    })}
  </h1>
));

storiesOf('I18n', module).add('Message with variable', () => (
  <div>
    <TitleComponent count={15} />
    <p>
      <FormattedMessage id="pages.home.not_signed_in.main_message_one" />
    </p>
  </div>
));
