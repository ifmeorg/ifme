import React from 'react';
import { storiesOf } from '@storybook/react';
import css from '../styles/_legacy.scss';

storiesOf('Buttons', module)
  .add('Solid', () => (
    <div>
      <button className={`${css.buttonXS} buttonXS`}>Extra Small Button</button>
      <br />
      <br />
      <button className={`${css.buttonS} buttonS`}>Small Button</button>
      <br />
      <br />
      <button className={`${css.buttonM} buttonM`}>Medium Button</button>
      <br />
      <br />
      <button className={`${css.buttonL} buttonL`}>Large Button</button>
    </div>
  ))
  .add('Ghost', () => (
    <div>
      <button className={`${css.buttonGhostXS} buttonGhostXS`}>
        Extra Small Button
      </button>
      <br />
      <br />
      <button className={`${css.buttonGhostS} buttonGhostS`}>
        Small Button
      </button>
      <br />
      <br />
      <button className={`${css.buttonGhostM} buttonGhostM`}>
        Medium Button
      </button>
      <br />
      <br />
      <button className={`${css.buttonGhostL} buttonGhostL`}>
        Large Button
      </button>
    </div>
  ));
