import React from 'react';
import css from '../styles/_global.scss';

export default {
  title: 'Style Guide/Errors',
};

export const Errors = () => (
  <div className={`${css.errorField} error`}>
    <h2 className={`${css.errorText} error`}>errors</h2>
    <ul className={`${css.errorText} error`}>
      <li>this</li>
      <li>is</li>
      <li>an</li>
      <li>example</li>
    </ul>
  </div>
);
