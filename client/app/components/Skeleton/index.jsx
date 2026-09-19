// @flow
import React from 'react';
import type { Node } from 'react';
import css from './Skeleton.scss';

export type Props = {
  height: string,
  width?: string,
};

// Placeholder that takes up the space of content that is still loading,
// so the page does not shift once the content shows up.
export const Skeleton = ({ height, width = '100%' }: Props): Node => (
  <div className={css.skeleton} aria-busy="true">
    <div className={css.block} style={{ height, width }} aria-hidden="true" />
  </div>
);
