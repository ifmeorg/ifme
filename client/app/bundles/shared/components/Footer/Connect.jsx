import React from 'react';
import PropTypes from 'prop-types';
import css from './Footer.scss';

const Connect = props => (
  <ul>
    <h6 className={css.footer_header}>Connect</h6>
    <li><a href="mailto:join.ifme@gmail.com" target="blank">{props.common.form.email}</a></li>
    <li><a href="http://facebook.com/ifmeorg" target="blank">{props.navigation.facebook}</a></li>
    <li><a href="https://github.com/ifmeorg/ifme" target="blank">{props.navigation.github}</a></li>
    <li><a href="https://www.instagram.com/ifmeorg" target="blank">{props.navigation.instagram}</a></li>
    <li><a href="https://medium.com/ifme" target="blank">{props.navigation.medium}</a></li>
    <li><a href="https://opencollective.com/ifme" target="blank">{props.navigation.opencollective}</a></li>
    <li><a href="http://patreon.com/ifme" target="blank">{props.navigation.patreon}</a></li>
    <li><a href="https://medium.com/feed/ifme" target="blank">{props.navigation.rss}</a></li>
    <li><a href="http://twitter.com/ifmeorg" target="blank">{props.navigation.twitter}</a></li>
  </ul>
);

Connect.propTypes = {
  navigation: PropTypes.string.isRequired,
  common: PropTypes.string.isRequired,
};

export default Connect;
