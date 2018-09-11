// @flow
import React from 'react';
import { Chart } from './index';
import globalCss from '../../styles/_global.scss';
import css from './ChartControl.scss';

type chartControlState = {
  type: string,
  data: any,
};

type chartControlProp = {
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
export class ChartControl extends React.Component<
  chartControlProp,
  chartControlState,
> {
  props: chartControlProp;

  state: chartControlState;

  constructor(props: chartControlProp) {
    super(props);

    const { initialParams } = this.props;

    this.state = {
      type: initialParams.type,
      data: initialParams.data,
    };
  }

  onSelectType(value: string) {
    return () => {
      this.setState({ type: value });
    };
  }

  render() {
    const { types } = this.props;
    const { data, type } = this.state;
    return (
      <div className={css.chartControl}>
        <div>
          {types.map((value: string) => (
            <ChartControlButton
              key={value}
              type={value}
              onClick={this.onSelectType(value)}
            />
          ))}
        </div>
        <Chart
          ytitle={`${type}`}
          xtitle="Date"
          data={data[type]}
          chartType="Area"
        />
      </div>
    );
  }
}
