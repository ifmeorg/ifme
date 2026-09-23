// @flow
import React from 'react';
import type { Node } from 'react';
import css from './FeedbackBanner.scss';

export type Action = {
  label: string,
  onClick: Function,
  primary?: boolean,
};

export type Props = {
  message: string,
  actions: Action[],
};

export const FeedbackBanner = ({ message, actions }: Props): Node => (
  <div className={css.banner} role="status" aria-live="polite">
    <span className={css.message}>{message}</span>
    <div className={css.actions}>
      {actions.map((action) => (
        <button
          key={action.label}
          type="button"
          className={action.primary ? css.primaryButton : css.secondaryButton}
          onClick={action.onClick}
        >
          {action.label}
        </button>
      ))}
    </div>
  </div>
);

export default FeedbackBanner;
