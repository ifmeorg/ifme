import React from 'react';
import css from './Footer.scss';
import Resources from './Resources';
import Connect from './Connect';
import Ifme from './Ifme';

import enYML from '../../../../../../config/locales/en.yml';

const Footer = () => {
  const navProp = enYML.en.navigation;
  return (
    <div className={css.footer}>
      <div id={css.footer_contest}>
        <div className={css.table}>
          <div className={css.row}>
            <div className={`${css.table_cell} ${css.resources}`}>
              <Resources pages={enYML.en.pages.resources} navigation={navProp} />
            </div>
            <div className={`${css.table_cell} ${css.connect}`}>
              <Connect navigation={navProp} common={enYML.en.common} />
            </div>
            <div className={`${css.table_cell} ${css.if_me}`}>
              <Ifme app_name={enYML.en.app_name} navigation={navProp} />
            </div>
          </div>
          <div className={`${css.table_cell} ${css.love_foss}`}>
            <h4>We &hearts; FOSS</h4>
            <a className={css.license} href="https://github.com/ifmeorg/ifme/blob/master/LICENSE.txt" target="blank" >Licensed under AGPL-3.0</a>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Footer;
