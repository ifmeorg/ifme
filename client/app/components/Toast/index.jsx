// @flow
import React, { useState } from 'react';
import type { Node } from 'react';
import { I18n } from 'libs/i18n';
import css from './Toast.scss';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTimes } from '@fortawesome/free-solid-svg-icons';
type Props = {
  alert?: string,
  notice?: string,
  appendDashboardClass?: boolean
};
export type State = {
  showToast: boolean,
};

export const Toast = ({
  alert, notice, appendDashboardClass
}: Props): Node => {
  const [showAlert, setShowAlert] = useState<boolean>(alert !== null && alert !== '' && !document.documentElement.hasAttribute("data-turbolinks-preview"));
  const [showNotice, setShowNotice] = useState<boolean>(notice !== null && notice !== '' && !document.documentElement.hasAttribute("data-turbolinks-preview"));
  console.log('appendDashboardClass ', appendDashboardClass, showAlert, showNotice);
  const hideNotice = () => {
    setShowNotice(false);
  };
  const hideAlert = () => {
    setShowAlert(false);
  };
  if(showAlert || showNotice) {
    setTimeout(() => {
      hideNotice();
      hideAlert();
    }, 7000);
  }
  return (
    <>
      {
        <div id='toast-notice' aria-label={showNotice ? I18n.t('alert_auto_hide'): ''} style={{ visibility: showNotice ? "visible" : "hidden" }} role="region" aria-live="polite" aria-atomic="true" className={`${showNotice ? 'notice' : ''} ${css.toast} ${showNotice && (showAlert || appendDashboardClass) ? 'smallMarginBottom' : ''}`}>
          {
            (showNotice) &&
            <>
              <div>
                {notice}
              </div>
              <button type="button" onClick={hideNotice} aria-label={I18n.t('close')}>
                <span aria-hidden="true">
                  <FontAwesomeIcon icon={faTimes} />
                </span>
              </button>
            </>
          }
        </div>
      }
      {
        <div id='toast-alert' aria-label={showAlert ? I18n.t('alert_auto_hide'): ''} style={{ visibility: showAlert ? "visible" : "hidden" }} role="alert" aria-live="assertive" aria-atomic="true" className={`${showAlert ? 'alert' : ''} ${css.toast} ${showAlert && appendDashboardClass ? 'smallMarginBottom' : ''}`}>
          {
            (showAlert) &&
            <>
              <div>
                {alert}
              </div>
              <button type="button" onClick={hideAlert} aria-label={I18n.t('close')}>
                <span aria-hidden="true">
                  <FontAwesomeIcon icon={faTimes} />
                </span>
              </button>
            </>
          }
        </div>
      }
    </>
  );
};

export default ({
  alert, notice, appendDashboardClass
}: Props): Node => (
  <Toast alert={alert} notice={notice} appendDashboardClass={appendDashboardClass} />
);