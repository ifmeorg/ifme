import React from 'react';
import css from './Footer.scss';

const Footer = () => (
  <div className={css.footer}>
    <div id={css.footer_content}>
      <div className={css.table}>
        <div className={css.row}>
          <div className={[css.table_cell, css.resources].join(' ')}>
            <ul>
              <h6 className={css.footer_header}>Resources</h6>
              <li><a href="/resources?resource=communities">Communities</a></li>
              <li><a href="/resources?resource=education">Education</a></li>
              <li><a href="/resources?resource=hotlines">Hotlines</a></li>
              <li><a href="/resources?resource=services">Services</a></li>
            </ul>
          </div>
          <div className={[css.table_cell, css.connect].join(' ')}>
            <ul>
              <h6 className={css.footer_header}>Connect</h6>
              <li><a href="mailto:join.ifme@gmail.com" target="blank">Email</a></li>
              <li><a href="http://facebook.com/ifmeorg" target="blank">Facebook</a></li>
              <li><a href="https://github.com/ifmeorg/ifme" target="blank">Github</a></li>
              <li><a href="https://www.instagram.com/ifmeorg" target="blank">Instagram</a></li>
              <li><a href="https://medium.com/ifme" target="blank">Medium</a></li>
              <li><a href="https://opencollective.com/ifme" target="blank">Open collective</a></li>
              <li><a href="http://patreon.com/ifme" target="blank">Patreon</a></li>
              <li><a href="https://medium.com/feed/ifme" target="blank">RSS</a></li>
              <li><a href="http://twitter.com/ifmeorg" target="blank">Twitter</a></li>
            </ul>
          </div>
          <div className={[css.table_cell, css.if_me].join(' ')}>
            <ul>
              <h6 className={css.footer_header}>IF ME</h6>
              <li><a href="/about">About</a></li>
              <li><a href="/blog">Blog</a></li>
              <li><a href="/contribute">Contribute</a></li>
              <li><a href="/faq">FAQ</a></li>
              <li><a href="/partners">Partners</a></li>
              <li><a href="/press">Press</a></li>
              <li><a href="/privacy">Privacy Policy</a></li>
            </ul>
          </div>
        </div>
        <div className={[css.table_cell, css.love_foss].join(' ')}>
          <h4>We Love FOSS</h4>
          <p>Licensed under AGPL-3.0</p>
        </div>
      </div>
    </div>
  </div>
);

export default Footer;
