// @flow
import React from 'react';
import css from './SkipToContent.scss';
import { I18n } from '../../libs/i18n';

export type Props = {
  id?: string,
};

function SkipToContent(props: Props) {
  <div aria-label={I18n.t('navigation.skip_to_main_content')} /> 

  return <a className={css.skipToContent} href={`#${props.id}`}>Skip to main content</a>;
}

export default SkipToContent;

