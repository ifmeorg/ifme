import React from 'react';
import shortid from 'shortid';
import css from './Dropdown.scss';

import enYML from '../../../../../../config/locales/en.yml';


const options = Object.keys(enYML.en.languages).map(key =>
  (<option value={key} key={shortid.generate()} >
    {enYML.en.languages[key]}
  </option>),
);

export default variationClassName => () => (
  <div className={`${css.select_dropdown} ${variationClassName}`}>
    <select>
      {options}
    </select>
  </div>
);

