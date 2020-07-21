// @flow
import React from 'react';

import css from './SkipToContent.scss';
import { I18n } from '../../libs/i18n';

export type Props = {
  id: string,
};

const SkipToContent = ({ id }: Props) => (
  <a className={css.skipToContent} href={`#${id}`}>
    {I18n.t('navigation.skip_to_main_content')}
  </a>
);

export default SkipToContent;
