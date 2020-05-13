// @flow
import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faHeart } from '@fortawesome/free-solid-svg-icons';
import { Modal } from '../../components/Modal';
import { I18n } from '../../libs/i18n';
import css from './CrisisPrevention.scss';

const CrisisPrevention = () => (
  <Modal
    title={I18n.t('pages.resources.crisis_prevention.title')}
    body={(
      <>
        <a
          href={`/resources?filter[]=${I18n.t(
            'pages.resources.tags.hotlines',
          )}`}
        >
          {I18n.t('pages.resources.emergency')}
        </a>
        <p>
          {I18n.t('pages.resources.crisis_prevention.description')}
          {' '}
          <FontAwesomeIcon
            icon={faHeart}
            className={css.heart}
            aria-disabled="true"
          />
        </p>
      </>
    )}
    open
  />
);

export default CrisisPrevention;
