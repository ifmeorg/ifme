import React from 'react';
import PropTypes from 'prop-types';
import css from './Footer.scss';

const Ifme = props => (
  <ul>
    <h6 className={css.footer_header}>{props.app_name}</h6>
    <li><a href="/about">{props.navigation.about}</a></li>
    <li><a href="/blog">{props.navigation.blog}</a></li>
    <li><a href="/contribute">{props.navigation.contribute}</a></li>
    <li><a href="/faq">{props.navigation.faq}</a></li>
    <li><a href="/partners">{props.navigation.partners}</a></li>
    <li><a href="/press">{props.navigation.press}</a></li>
    <li><a href="/privacy">{props.navigation.privacy}</a></li>
  </ul>
);

Ifme.propTypes = {
  navigation: PropTypes.string.isRequired,
  app_name: PropTypes.string.isRequired,
};

export default Ifme;
