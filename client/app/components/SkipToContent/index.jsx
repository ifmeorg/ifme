// @flow
import React from 'react';
import css from './SkipToContent.scss';
import { I18n } from '../../libs/i18n';
import { Link } from 'react-router-dom';

export type Props = {
  id: string,
};

function SkipToContent(props: Props) {
  const { id } = props;
  // SkipToContent.removeEventHandler("Props", scrollTo);

  return (
    <Link className={css.skipToContent} to={`#${id}`}>
      {I18n.t('navigation.skip_to_main_content')}
    </Link>
  );
}

export default SkipToContent;
