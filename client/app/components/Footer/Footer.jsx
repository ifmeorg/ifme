// @flow
import React from 'react';
import { injectIntl } from 'react-intl';

import { defaultMessages } from 'libs/i18n/default';
import { availableLocalesAsSelectOptions } from 'libs/i18n/I18nUtils';

import { Connect } from './Connect';
import { DropdownGhostSmall } from '../Dropdown/DropdownGhostSmall';
import { Ifme } from './Ifme';
import { Resources } from './Resources';

import css from './Footer.scss';

const we = defaultMessages.sharedFooterLicenseWe;
const foss = defaultMessages.sharedFooterLicenseFoss;
const licenseSubtitle = defaultMessages.sharedFooterLicenseSubtitle;
const licenseName = defaultMessages.sharedFooterLicenceName;

type FooterProps = {
  intl: Object,
  onChange?: (locale: string) => void,
};

const TableCell = ({ children, className }: any) => (
  <div className={`${css.table_cell} ${className || ''}`}>{children}</div>
);

export const Footer = injectIntl(
  ({ intl, onChange = () => {} }: FooterProps) => {
    const { formatMessage } = intl;
    const changeHandler = ({ target }) => onChange(target.value);
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
                onChange={changeHandler}
                options={availableLocalesAsSelectOptions}
                value={intl.locale}
              />
            </div>
            <div className={`${css.table_cell} ${css.love_foss}`}>
              <h4>
                {formatMessage(we)} &hearts; {formatMessage(foss)}
              </h4>
              <a
                className={css.license}
                rel="noopener noreferrer"
                href="https://github.com/ifmeorg/ifme/blob/master/LICENSE.txt"
                target="_blank"
              >
                {formatMessage(licenseSubtitle, {
                  license: formatMessage(licenseName),
                })}
              </a>
            </div>
          </div>
        </div>
      </div>
    );
  },
);

Footer.displayName = 'Footer';
