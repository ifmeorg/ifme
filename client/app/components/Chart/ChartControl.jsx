// @flow
import React, { useState } from 'react';
import { I18n } from 'libs/i18n';
import { Chart } from './index';
import globalCss from '../../styles/_global.scss';
import css from './ChartControl.scss';

type chartControlProps = {
  types: string[],
  initialParams: {
    type: string,
    data: {},
  },
};

type ChartControlButtonProps = {
  type: string,
  onClick: (type: string) => void,
};

const ChartControlButton = ({ type, onClick }: ChartControlButtonProps) => (
  <button type="button" className={globalCss.buttonDarkXS} onClick={onClick}>
    {type}
  </button>
);

/**
 * Control Panel for selecting different objects to graph.
 */
export const ChartControl = ({
  types,
  initialParams: { type: initialType, data },
}: chartControlProps) => {
  const [type: string, setType] = useState(initialType);

  const onSelectType = (value: string) => () => {
    setType(value);
  };

  return (
    <div className={css.chartControl} role="presentation">
      <div>
        {types.map((value: string) => (
          <ChartControlButton
            key={value}
            type={value}
            onClick={onSelectType(value)}
          />
        ))}
      </div>
      <Chart
        ytitle={`${type}`}
        xtitle={I18n.t('common.date')}
        data={data[type]}
        chartType="Area"
      />
    </div>
  );
};
