import React, { Fragment } from 'react';
import { storiesOf } from '@storybook/react';
import css from '../styles/_global.scss';

const rowStyle = {
  display: 'flex',
  flexDirection: 'row',
  justifyContent: 'space-evenly',
};

function getButton(className) {
  return (
    <p>
      <button type="button" className={`${css[className]} ${className}`}>
        {`${className}`}
      </button>
    </p>
  );
}

function getMargin(className) {
  return (
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
}

function getColor(background, textColor, name) {
  return (
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
}

function getGrid(gridSize, itemType) {
  const itemClassName = `${gridSize}${itemType}`;
  const gridItem = (
    <div className={`${css[itemClassName]} ${itemClassName}`}>
      {`${itemClassName}`}
    </div>
  );
  const moreThanTwo = ['gridThree', 'gridMany'];
  return (
    <div className={`${css[gridSize]} gridSize`}>
      {gridItem}
      {gridItem}
      {moreThanTwo.includes(gridSize) ? gridItem : null}
    </div>
  );
}

storiesOf('Style Guide', module)
  .add(
    'Buttons',
    () => (
      <div style={rowStyle}>
        <div>
          <h1>Default</h1>
          {getButton('buttonXS')}
          {getButton('buttonS')}
          {getButton('buttonM')}
          {getButton('buttonL')}
        </div>
        <div>
          <h1>Ghost</h1>
          {getButton('buttonGhostXS')}
          {getButton('buttonGhostS')}
          {getButton('buttonGhostM')}
          {getButton('buttonGhostL')}
        </div>
        <div>
          <h1>Dark</h1>
          {getButton('buttonDarkXS')}
          {getButton('buttonDarkS')}
          {getButton('buttonDarkM')}
          {getButton('buttonDarkL')}
        </div>
      </div>
    ),
    {
      notes: {
        markdown:
          '*Default* can be used for anything. *Ghost* is for pages that are pre-login. *Dark* is for your account pages',
      },
    },
  )
  .add('Error', () => (
    <div className={`${css.errorField} error`}>
      <h2 className={`${css.errorText} error`}>errors</h2>
      <ul className={`${css.errorText} error`}>
        <li>this</li>
        <li>is</li>
        <li>an</li>
        <li>example</li>
      </ul>
    </div>
  ))
  .add('Grids', () => (
    <Fragment>
      {getGrid('gridTwo', 'ItemBoxDark')}
      {getGrid('gridTwo', 'ItemBoxGhost')}
      {getGrid('gridTwo', 'ItemBoxLight')}
      {getGrid('gridThree', 'ItemBoxDark')}
      {getGrid('gridThree', 'ItemBoxGhost')}
      {getGrid('gridThree', 'ItemBoxLight')}
      {getGrid('gridMany', 'Item')}
    </Fragment>
  ))
  .add('Margins', () => (
    <Fragment>
      {getMargin('marginRight')}
      {getMargin('smallMarginRight')}
      {getMargin('marginLeft')}
      {getMargin('smallMarginLeft')}
      {getMargin('marginTop')}
      {getMargin('smallMarginTop')}
      {getMargin('marginBottom')}
      {getMargin('smallMarginBottom')}
      {getMargin('noMarginBottom')}
    </Fragment>
  ))
  .add('Colors', () => (
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
  ))
  .add('Fonts', () => (
    <Fragment>
      <p style={{ fontWeight: '100' }}>$font-weight-100</p>
      <p style={{ fontWeight: '200' }}>$font-weight-200</p>
      <p style={{ fontWeight: '300' }}>$font-weight-300</p>
      <p style={{ fontWeight: '400' }}>$font-weight-400</p>
    </Fragment>
  ));
