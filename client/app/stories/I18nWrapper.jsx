import React from 'react';
import { IntlProvider, injectIntl } from 'react-intl';

import { DropdownGhost } from 'bundles/shared/components/Dropdown';

import { defaultMessages, defaultLocale } from 'libs/i18n/default';
import { getMessages } from 'libs/i18n/I18nUtils';
import { loadLocales } from 'libs/i18n/I18nSetup';

export default class I18nWrapper extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      locale: defaultLocale,
    };
  }

  componentDidMount() {
    loadLocales();
  }

  render() {
    const TitleComponent = injectIntl(({ intl }) => (
      <div>
        {intl.formatMessage(defaultMessages.appDescription)}
      </div>
    ));

    return (
      <IntlProvider
        locale={this.state.locale}
        key={this.state.locale}
        messages={getMessages(this.state.locale)}
      >
        <div>
          <TitleComponent />
          <DropdownGhost
            onChange={selectedLocale => this.setState({ locale: selectedLocale })}
            locale={this.state.locale}
          />
        </div>
      </IntlProvider>
    );
  }
}
