// @flow
import React from 'react';
import _ from 'lodash';
import Chart from './Chart';

type chartControlState = {
  type: string;
  aggregateFunc: string;
  data: any;
}

type chartControlProp = {
  onChange: (type: string, callback: (data: {}) => void) => void;
  types: string[];
  initialParams: {
    type: string,
    aggregateFunc: string,
  };
}

const ChartControlButton = (index: number, type: string, onClick: (type: string) => void) => {
  return (<button key={index} onClick={onClick}>{type}</button>);
};

/**
 * Control Panel for selecting different objects to analyze for moments.
 */
export default class ChartControl extends React.Component {
  props: chartControlProp;
  state: chartControlState;

  constructor(props: chartControlProp) {
    super(props);

    const { initialParams } = this.props;

    this.state = {
      type: initialParams.type,
      aggregateFunc: initialParams.aggregateFunc,
      data: null,
    };
  }

  componentDidMount() {
    this.triggerOnChange(this.state.type);
  }

  triggerOnChange(type: string) {
    const { onChange } = this.props;
    onChange(type, (data: {}) => this.updateChart(type, data));
  }

  updateChart(type: string, data: {}) {
    this.setState({ data, type });
  }

  onSelectType(type: string): () => void {
    return () => this.triggerOnChange(type);
  }

  render() {
    const { types } = this.props;
    const buttons: any[] = [];
    _.each(types, (value, index: number) => {
      buttons.push(new ChartControlButton(index, value, this.onSelectType(value)));
    });
    return (
      <div>
        {buttons}
        { _.isNil(this.state.data) ? null
          : <Chart ytitle={`${this.state.type} ${this.state.aggregateFunc}`} xtitle="Date" data={this.state.data} />
        }
      </div>
    );
  }
}
