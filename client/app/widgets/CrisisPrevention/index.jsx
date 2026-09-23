// @flow
import React, { useState } from 'react';
import type { Node } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faHeart } from '@fortawesome/free-solid-svg-icons/faHeart';
import { I18n } from 'libs/i18n';
import Modal from 'components/Modal';
import { fetchWrapper } from 'utils/fetchWrapper';
import globalCss from 'styles/_global.scss';
import css from './CrisisPrevention.scss';

type Props = {
  momentId?: number,
  acknowledged: boolean,
};

const CrisisPrevention = ({ momentId, acknowledged }: Props): Node => {
  const [isVisible, setIsVisible] = useState(!acknowledged);

  if (!isVisible) return null;

  const handleAcknowledge = () => {
    const url = momentId
      ? `/moments/${momentId}/acknowledge_crisis_prevention`
      : '/moments/acknowledge_all_crisis_prevention';
    fetchWrapper.post(url).catch(() => {});
    setIsVisible(false);
  };

  return (
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
          <p>
            <a href="/care_plan">
              {I18n.t('pages.resources.crisis_prevention.care_plan_link')}
            </a>
          </p>
          <button
            type="button"
            className={globalCss.buttonDarkM}
            onClick={handleAcknowledge}
          >
            {I18n.t('pages.resources.crisis_prevention.acknowledge')}
          </button>
        </>
      )}
      open
    />
  );
};

export default CrisisPrevention;
