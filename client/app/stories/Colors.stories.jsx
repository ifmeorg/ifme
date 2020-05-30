import React from 'react';
import css from '../styles/_global.scss';

const getColor = (background, textColor, name) => (
  <div className={`${css.gridManyItem} gridManyItem`}>
    <div
      style={{
        background,
        color: textColor,
        padding: '10px',
        textAlign: 'center',
      }}
    >
      <h3>{`$${name}`}</h3>
      <p>{`${background}`}</p>
    </div>
  </div>
);

export default {
  title: 'Style Guide/Colors',
};

export const Colors = () => (
  <div className={`${css.gridMany} gridMany`}>
    {getColor('#808080', 'white', 'grey')}
    {getColor('#D3D3D3', 'black', 'light-grey')}
    {getColor('#FFFFFF', 'black', 'white')}
    {getColor('#A157E8', 'white', 'purple-yay')}
    {getColor('#175C6D', 'white', 'blumine')}
    {getColor('#91D7E8', 'black', 'cornflower')}
    {getColor('#289900', 'white', 'limeade')}
    {getColor('#990019', 'white', 'carmine')}
    {getColor('#704356', 'white', 'eggplant')}
    {getColor('#6d0839', 'white', 'mulberry')}
    {getColor('#D0E799', 'black', 'key-lime')}
    {getColor(
      'linear-gradient(104.26deg, #6d0839 0%, #D0E799 175.81%)',
      'white',
      'mulberry-key-lime',
    )}
  </div>
);
