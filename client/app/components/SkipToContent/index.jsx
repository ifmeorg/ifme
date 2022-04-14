// @flow
import React from 'react';
import type { Node } from 'react';

import { I18n } from 'libs/i18n';
import css from './SkipToContent.scss';

export type Props = {
  id: string,
};

const SkipToContent = ({ id }: Props): Node => (
  <a className={css.skipToContent} href={`#${id}`}>
    {I18n.t('navigation.skip_to_main_content')}
  </a>
);

export default SkipToContent;
