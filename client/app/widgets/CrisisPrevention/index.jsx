// @flow
import React from 'react';
import type { Node } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faHeart } from '@fortawesome/free-solid-svg-icons';
import { I18n } from 'libs/i18n';
import Modal from 'components/Modal';
import css from './CrisisPrevention.scss';

const CrisisPrevention = (): Node => (
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
