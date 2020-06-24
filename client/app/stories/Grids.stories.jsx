import React from 'react';
import css from '../styles/_global.scss';

const getGrid = (gridSize, itemType) => {
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
};

export default {
  title: 'Style Guide/Grids',
};

export const Grids = () => (
  <>
    {getGrid('gridTwo', 'ItemBoxDark')}
    {getGrid('gridTwo', 'ItemBoxGhost')}
    {getGrid('gridTwo', 'ItemBoxLight')}
    {getGrid('gridThree', 'ItemBoxDark')}
    {getGrid('gridThree', 'ItemBoxGhost')}
    {getGrid('gridThree', 'ItemBoxLight')}
    {getGrid('gridMany', 'Item')}
  </>
);
