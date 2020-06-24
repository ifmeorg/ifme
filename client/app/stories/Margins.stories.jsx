import React from 'react';
import css from '../styles/_global.scss';

const rowStyle = {
  display: 'flex',
  flexDirection: 'row',
  justifyContent: 'space-evenly',
};

const getMargin = (className) => (
  <div style={{ ...rowStyle, padding: '10px' }}>
    <div>{`${className}`}</div>
    <div
      className={`${css[className]} ${className}`}
      style={{
        width: '100px',
        height: '100px',
        background: 'black',
      }}
    />
  </div>
);

export default {
  title: 'Style Guide/Margins',
};

export const Margins = () => (
  <>
    {getMargin('marginRight')}
    {getMargin('smallMarginRight')}
    {getMargin('marginLeft')}
    {getMargin('smallMarginLeft')}
    {getMargin('marginTop')}
    {getMargin('smallMarginTop')}
    {getMargin('marginBottom')}
    {getMargin('smallMarginBottom')}
    {getMargin('noMarginBottom')}
  </>
);
