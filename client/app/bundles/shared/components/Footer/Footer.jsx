// @flow
import React from 'react';
import { IntlProvider, injectIntl } from 'react-intl';
import { defaultMessages, defaultLocale } from 'libs/i18n/default';
import { getMessages } from 'libs/i18n/I18nUtils';
import css from './Footer.scss';
import Resources from './Resources';
import Connect from './Connect';
import Ifme from './Ifme';
import DropdownGhostSmall from '../Dropdown/DropdownGhostSmall';

const we = defaultMessages.sharedFooterLicenseWe;
const foss = defaultMessages.sharedFooterLicenseFoss;
const licenseSubtitle = defaultMessages.sharedFooterLicenseSubtitle;
const licenseName = defaultMessages.sharedFooterLicenceName;

type FooterProps = {
  intl: Object,
  onChange: (locale: string) => void,
}

const TableCell = (props: { children: any }) => (<div className={`${css.table_cell}`}>{props.children}</div>);

const InjectedFooter = injectIntl(({ intl, onChange }: FooterProps) => {
  const { formatMessage } = intl;
  return (
    <div className={css.footer}>
      <div className={css.table}>
        <div className={css.row}>
          <TableCell className={css.if_me}>
            <Ifme />
          </TableCell>
          <TableCell className={css.connect}>
            <Connect />
          </TableCell>
          <div className={`${css.table_cell} ${css.resources}`}>
            <Resources />
          </div>
          <div className={`${css.table_cell} ${css.dropdown}`}>
            <DropdownGhostSmall
              onChange={onChange}
              locale={intl.locale}
            />
          </div>
          <div className={`${css.table_cell} ${css.love_foss}`}>
            <h4>{formatMessage(we)} &hearts; {formatMessage(foss)}</h4>
            <a className={css.license} href="https://github.com/ifmeorg/ifme/blob/master/LICENSE.txt" target="_blank">
              {formatMessage(licenseSubtitle, { license: formatMessage(licenseName) })}
            </a>
          </div>
        </div>
      </div>
    </div>
  );
});

type Props = {
  locale: string
};

type State = {
  locale: string
}

export default class Footer extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      locale: props.locale || defaultLocale,
    };
  }

  render() {
    return (
      <IntlProvider
        locale={this.state.locale}
        key={this.state.locale}
        messages={getMessages(this.state.locale)}
      >
        <InjectedFooter
          onChange={selected => this.setState({ locale: selected })}
        />
      </IntlProvider>
    );
  }
}
