import React, { Fragment } from 'react';
import { storiesOf } from '@storybook/react';
import css from '../styles/_global.scss';

const buttonsGroupStyle = {
  display: 'inline',
  right: '10px',
  margin: '0 auto',
  textAlign: 'center',
  backgroundColor: 'transparent',
  paddingBottom: '10px',
};

const marginGroupStyle = {
  display: 'inline-block',
  border: '1px solid',
  padding: '10px',
};

const colorsContainer = {
  margin: '10px 5px',
  height: 'auto',
  width: 'auto',
  borderRadius: '5px',
  textAlign: 'center',
  padding: '10px 5px',
  background: 'white',
};

storiesOf('Styleguide', module)
  .add(
    'Buttons',
    () => (
      <div style={buttonsGroupStyle}>
        <div
          style={{
            width: '33%',
            float: 'left',
            backgroundColor: '#D3D3D3',
            paddingBottom: '20px',
            margin: '0 auto',
          }}
        >
          <h1>Default</h1>
          <button type="button" className={`${css.buttonXS} buttonXS`}>
            buttonXS
          </button>
          <br />
          <br />
          <button type="button" className={`${css.buttonS} buttonS`}>
            buttonS
          </button>
          <br />
          <br />
          <button type="button" className={`${css.buttonM} buttonM`}>
            buttonM
          </button>
          <br />
          <br />
          <button type="button" className={`${css.buttonL} buttonL`}>
            buttonL
          </button>
        </div>
        <div style={buttonsGroupStyle}>
          <h1>Ghost</h1>
          <button
            type="button"
            className={`${css.buttonGhostXS} buttonGhostXS`}
          >
            buttonGhostXS
          </button>
          <br />
          <br />
          <button type="button" className={`${css.buttonGhostS} buttonGhostS`}>
            buttonGhostS
          </button>
          <br />
          <br />
          <button type="button" className={`${css.buttonGhostM} buttonGhostM`}>
            buttonGhostM
          </button>
          <br />
          <br />
          <button type="button" className={`${css.buttonGhostL} buttonGhostL`}>
            ButtonGhostL
          </button>
        </div>
        <div
          style={{
            width: '33%',
            float: 'left',
            backgroundColor: '#D3D3D3',
            paddingBottom: '20px',
            margin: '0 auto',
          }}
        >
          <h1>Dark</h1>
          <button type="button" className={`${css.buttonDarkXS} buttonDarkXS`}>
            buttonDarkXS
          </button>
          <br />
          <br />
          <button type="button" className={`${css.buttonDarkS} buttonDarkS`}>
            buttonDarkS
          </button>
          <br />
          <br />
          <button type="button" className={`${css.buttonDarkM} buttonDarkM`}>
            buttonDarkM
          </button>
          <br />
          <br />
          <button type="button" className={`${css.buttonDarkL} buttonDarkL`}>
            buttonDarkL
          </button>
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
  .add('Forms', () => (
    <form>
      <label htmlFor="label" className={`${css.label} label`}>
        label
        <br />
        <input
          style={{ marginBottom: '10px' }}
          type="text"
          className={`${css.inputStyle} inputStyle`}
          placeholder="inputStyle"
        />
        <br />
        <textarea />
      </label>
    </form>
  ))
  .add(
    'Grids',
    () => (
      <Fragment>
        <div className={`${css.gridTwo} gridTwo`}>
          <div
            className={`${css.gridTwoItemBoxDark} gridTwoItemBoxDark`}
            style={{ border: '2px solid' }}
          >
            gridTwoItem
          </div>
          <div
            className={`${css.gridTwoItemBoxDark} gridTwoItemBoxDark`}
            style={{ border: '2px solid' }}
          >
            gridTwoItem
          </div>
        </div>
        <div className={`${css.gridThree} gridThree`}>
          <div
            className={`${css.gridThreeItemBoxGhost}  gridThreeItemBoxGhost`}
            style={{ border: '2px solid' }}
          >
            gridThreeItem
          </div>
          <div
            className={`${css.gridThreeItemBoxGhost}  gridThreeItemBoxGhost`}
            style={{ border: '2px solid' }}
          >
            gridThreeItem
          </div>
          <div
            className={`${css.gridThreeItemBoxGhost}  gridThreeItemGhost`}
            style={{ border: '2px solid' }}
          >
            gridThreeItem
          </div>
        </div>
        <div
          className={`${css.gridThree} gridThree`}
          style={{ margin: '10px' }}
        >
          <div
            className={`${css.gridThreeItemBoxLight}  gridThreeItemBoxLight`}
            style={{ margin: '10px' }}
          >
            <h1 className={`${css.gridh1}  gridh1`}>gridItemBoxLight</h1>
          </div>
          <div
            className={`${css.gridThreeItemBoxDark}  gridThreeItemBoxDark `}
            style={{ margin: '10px' }}
          >
            <h1 className={`${css.gridh1}  gridh1`}>gridItemBoxDark</h1>
          </div>
          <div
            className={`${css.gridThreeItemBoxGhost}  gridThreeItemBoxGhost`}
            style={{ margin: '10px' }}
          >
            <h1 className={`${css.gridh1}  gridh1`}>gridItemBoxGhost</h1>
          </div>
        </div>
      </Fragment>
    ),
    { notes: { markdown: '# hi' } },
  )
  .add('Margins', () => (
    <Fragment>
      <div
        style={{
          margin: '10px',
        }}
      >
        <div
          className={`${css.marginRight} marginRight`}
          style={marginGroupStyle}
        >
          marginRight
        </div>
        <div style={marginGroupStyle}>marginRight</div>
      </div>
      <div
        style={{
          margin: '10px',
        }}
      >
        <div
          className={`${css.smallMarginRight} smallMarginRight`}
          style={marginGroupStyle}
        >
          smallMarginRight
        </div>
        <div style={marginGroupStyle}>smallMarginRight</div>
      </div>
      <div
        style={{
          margin: '10px',
        }}
      >
        <div
          className={`${css.marginLeft} marginLeft`}
          style={marginGroupStyle}
        >
          marginLeft
        </div>
      </div>
      <div
        style={{
          margin: '10px',
        }}
      >
        <div
          className={`${css.smallMarginLeft} smallMarginLeft`}
          style={marginGroupStyle}
        >
          smallMarginLeft
        </div>
      </div>
    </Fragment>
  ))
  .add('Colors', () => (
    <Fragment>
      <div className={`${css.gridThree} gridThree`} style={{ margin: '10px' }}>
        <div
          className={`${css.gridThreeItemBox} gridThreeItemBox`}
          style={colorsContainer}
        >
          <div style={{ background: '#808080', color: 'white' }}>
            <h3>$grey</h3>
            <p>#808080</p>
          </div>
        </div>
        <div
          className={`${css.gridThreeItemBox} gridThreeItemBox`}
          style={colorsContainer}
        >
          <div style={{ background: '#D3D3D3' }}>
            <h3>$light-grey</h3>
            <p>#D3D3D3</p>
          </div>
        </div>
        <div
          className={`${css.gridThreeItemBox} gridThreeItemBox`}
          style={colorsContainer}
        >
          <h3>$white</h3>
          <p>#FFFFFF</p>
        </div>
        <div
          className={`${css.gridThreeItemBox} gridThreeItemBox`}
          style={colorsContainer}
        >
          <div style={{ background: '#A157E8', color: 'white' }}>
            <h3>$purple-yay</h3>
            <p>#A157E8</p>
          </div>
        </div>
        <div
          className={`${css.gridThreeItemBox} gridThreeItemBox`}
          style={colorsContainer}
        >
          <div style={{ background: '#175C6D', color: 'white' }}>
            <h3>$blumine</h3>
            <p>#175C6D</p>
          </div>
        </div>
        <div
          className={`${css.gridThreeItemBox} gridThreeItemBox`}
          style={colorsContainer}
        >
          <div style={{ background: '#91D7E8' }}>
            <h3>$cornflower</h3>
            <p>#91D7E8</p>
          </div>
        </div>
        <div
          className={`${css.gridThreeItemBox} gridThreeItemBox`}
          style={colorsContainer}
        >
          <div style={{ background: '#289900', color: 'white' }}>
            <h3>$limeade</h3>
            <p>#289900</p>
          </div>
        </div>
        <div
          className={`${css.gridThreeItemBox} gridThreeItemBox`}
          style={colorsContainer}
        >
          <div style={{ background: '#990019', color: 'white' }}>
            <h3>$carmine</h3>
            <p>#990019</p>
          </div>
        </div>
        <div
          className={`${css.gridThreeItemBox} gridThreeItemBox`}
          style={colorsContainer}
        >
          <div style={{ background: '#704356', color: 'white' }}>
            <h3>$eggplant</h3>
            <p>#704356</p>
          </div>
        </div>
        <div
          className={`${css.gridThreeItemBox} gridThreeItemBox`}
          style={colorsContainer}
        >
          <div style={{ background: '#6d0839', color: 'white' }}>
            <h3>$mulberry</h3>
            <p>#6d0839</p>
          </div>
        </div>
        <div
          className={`${css.gridThreeItemBox} gridThreeItemBox`}
          style={colorsContainer}
        >
          <div style={{ background: '#D0E799' }}>
            <h3>$key-lime</h3>
            <p>#D0E799</p>
          </div>
        </div>
        <div
          className={`${css.gridThreeItemBox} gridThreeItemBox`}
          style={colorsContainer}
        >
          <div
            style={{
              background:
                'linear-gradient(104.26deg, #6d0839 0%, #D0E799 175.81%)',
              color: 'white',
            }}
          >
            <h3>$mulberry-key-lime</h3>
            <p>linear-gradient(104.26deg, $mulberry 0%, $key-lime 175.81%)</p>
          </div>
        </div>
      </div>
    </Fragment>
  ))
  .add('Fonts', () => (
    <Fragment>
      <p style={{ fontWeight: '100' }}>$font-weight-100</p>
      <p style={{ fontWeight: '200' }}>$font-weight-200</p>
      <p style={{ fontWeight: '300' }}>$font-weight-300</p>
      <p style={{ fontWeight: '400' }}>$font-weight-400</p>
    </Fragment>
  ));
