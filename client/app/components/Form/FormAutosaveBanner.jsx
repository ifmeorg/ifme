// @flow
import React from 'react';
import type { Node } from 'react';
import { I18n } from 'libs/i18n';
import globalCss from 'styles/_global.scss';
import css from './FormAutosaveBanner.scss';

type Props = {
  savedAt: number,
  onRestore: () => void,
  onDismiss: () => void,
};

const formatTimeDiff = (timestamp: number): string => {
  const diffMs = Date.now() - timestamp;
  const diffMin = Math.floor(diffMs / 60000);
  if (diffMin < 1) return I18n.t('common.autosave.time_just_now');
  if (diffMin === 1) return I18n.t('common.autosave.time_one_minute');
  if (diffMin < 60) return I18n.t('common.autosave.time_minutes_ago', { count: String(diffMin) });
  const diffHr = Math.floor(diffMin / 60);
  if (diffHr === 1) return I18n.t('common.autosave.time_one_hour');
  return I18n.t('common.autosave.time_hours_ago', { count: String(diffHr) });
};

export const FormAutosaveBanner = ({ savedAt, onRestore, onDismiss }: Props): Node => (
  <div className={css.banner} role="status" aria-live="polite">
    <span className={css.message}>
      {I18n.t('common.autosave.restore_prompt', { time: formatTimeDiff(savedAt) })}
    </span>
    <div className={css.actions}>
      <button
        type="button"
        className={globalCss.buttonS}
        onClick={onRestore}
      >
        {I18n.t('common.autosave.restore_button')}
      </button>
      <button
        type="button"
        className={globalCss.buttonGhostS}
        onClick={onDismiss}
      >
        {I18n.t('common.autosave.dismiss')}
      </button>
    </div>
  </div>
);

export default FormAutosaveBanner;
