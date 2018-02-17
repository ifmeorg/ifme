import React from 'react';
import css from './Footer.scss';
import Resources from './Resources';
import Connect from './Connect';
import Ifme from './Ifme';
import DropdownGhostSmall from '../Dropdown/DropdownGhostSmall';

import enYML from '../../../../../../config/locales/en.yml';

const navProp = enYML.en.navigation;
const we = enYML.en.shared.footer.license_we;
const foss = enYML.en.shared.footer.license_foss;

const Footer = () => (
  <div className={css.footer}>
    <div id={css.footer_contest}>
      <div className={css.table}>
        <div className={css.row}>
          <div className={`${css.table_cell} ${css.if_me}`}>
            <Ifme app_name={enYML.en.app_name} navigation={navProp} />
          </div>
          <div className={`${css.table_cell} ${css.connect}`}>
            <Connect navigation={navProp} common={enYML.en.common} />
          </div>
          <div className={`${css.table_cell} ${css.resources}`}>
            <Resources pages={enYML.en.pages.resources} navigation={navProp} />
          </div>
          <div className={`${css.table_cell} ${css.dropdown}`}>
            <DropdownGhostSmall />
          </div>
          <div className={`${css.table_cell} ${css.love_foss}`}>
            <h4>{we} &hearts; {foss}</h4>
            <a className={css.license} href="https://github.com/ifmeorg/ifme/blob/master/LICENSE.txt" target="blank" >
              {enYML.en.shared.footer.license_subtitle} {enYML.en.shared.footer.licence_name}
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
);

export default Footer;
