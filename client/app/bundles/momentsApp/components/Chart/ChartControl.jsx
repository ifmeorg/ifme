// @flow
import React from 'react';
import Chart from './Chart';

type chartControlState = {
  type: string;
  data: any;
}

type chartControlProp = {
  types: string[];
  initialParams: {
    type: string,
    data: {}
  };
}

type ChartControlButtonProps = {
  type: string,
  onClick: (type: string) => void,
}

const ChartControlButton =
  ({ type, onClick }: ChartControlButtonProps) => (
    <button
      className={'ui-button ui-widget ui-corner-all'}
      onClick={onClick}
    >
      {type}
    </button>);

/**
 * Control Panel for selecting different objects to graph.
 */
export default class ChartControl extends React.Component<chartControlProp, chartControlState> {
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
      <div>
        {
          types.map((value: string, index: number) => (
            <ChartControlButton
              key={index}
              type={value}
              onClick={this.onSelectType(value)}
            />
          ))
        }
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
