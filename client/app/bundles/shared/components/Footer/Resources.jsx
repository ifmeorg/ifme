import React from 'react';
import PropTypes from 'prop-types';
import css from './Footer.scss';

const Resources = props => (
  <ul>
    <h6 className={css.footer_header}>{props.navigation.resources}</h6>
    <li><a href="/resources?resource=communities">{props.pages.communities}</a></li>
    <li><a href="/resources?resource=education">{props.pages.education}</a></li>
    <li><a href="/resources?resource=hotlines">{props.pages.hotlines}</a></li>
    <li><a href="/resources?resource=services">{props.pages.services}</a></li>
  </ul>
);

Resources.propTypes = {
  pages: PropTypes.string.isRequired,
  navigation: PropTypes.string.isRequired,
};

export default Resources;
