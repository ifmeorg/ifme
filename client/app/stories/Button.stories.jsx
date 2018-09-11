import React from 'react';
import { storiesOf } from '@storybook/react';
import css from '../styles/_global.scss';

storiesOf('Button', module)
  .add('Default', () => (
    <div>
      <button type="button" className={`${css.buttonXS} buttonXS`}>
        Extra Small Button
      </button>
      <br />
      <br />
      <button type="button" className={`${css.buttonS} buttonS`}>
        Small Button
      </button>
      <br />
      <br />
      <button type="button" className={`${css.buttonM} buttonM`}>
        Medium Button
      </button>
      <br />
      <br />
      <button type="button" className={`${css.buttonL} buttonL`}>
        Large Button
      </button>
    </div>
  ))
  .add('Ghost', () => (
    <div>
      <button type="button" className={`${css.buttonGhostXS} buttonGhostXS`}>
        Extra Small Button
      </button>
      <br />
      <br />
      <button type="button" className={`${css.buttonGhostS} buttonGhostS`}>
        Small Button
      </button>
      <br />
      <br />
      <button type="button" className={`${css.buttonGhostM} buttonGhostM`}>
        Medium Button
      </button>
      <br />
      <br />
      <button type="button" className={`${css.buttonGhostL} buttonGhostL`}>
        Large Button
      </button>
    </div>
  ))
  .add('Dark', () => (
    <div>
      <button type="button" className={`${css.buttonDarkXS} buttonDarkXS`}>
        Extra Small Button
      </button>
      <br />
      <br />
      <button type="button" className={`${css.buttonDarkS} buttonDarkS`}>
        Small Button
      </button>
      <br />
      <br />
      <button type="button" className={`${css.buttonDarkM} buttonDarkM`}>
        Medium Button
      </button>
      <br />
      <br />
      <button type="button" className={`${css.buttonDarkL} buttonDarkL`}>
        Large Button
      </button>
    </div>
  ));
