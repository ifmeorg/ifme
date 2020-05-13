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
  const [scroll, setScroll] = useState(false);
  const aToScroll = document.getElementById(id).useCallback(() => {
    setIsFocused(true);
  }, []);

  return (
    <a
      className={css.skipToContent}
      onClick={aToScroll}
      href={`#${id}`}
      >
      {I18n.t('navigation.skip_to_main_content')}
    </a>
  );
}

export default SkipToContent;