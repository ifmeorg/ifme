/* eslint-disable no-unused-vars */
import React from 'react';
import css from 'styles/_global.scss';

export default {
  title: 'Style Guide/Errors',
};

const Template = (args) => (
  <div className={`${css.errorField} errorField`}>
    <h2 className={`${css.errorText} errorText`}>errors</h2>
    <ul className={`${css.errorText} errorText`}>
      <li>this</li>
      <li>is</li>
      <li>an</li>
      <li>example</li>
    </ul>
  </div>
);

export const Default = Template.bind({});
