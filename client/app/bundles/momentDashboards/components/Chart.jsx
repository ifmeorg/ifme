// @flow
import 'chart.js';
import PropTypes from 'prop-types';
import React from 'react';
import { AreaChart } from 'react-chartkick';

// const request = require('superagent');

type chartProps = {
  title: string,
    data: {},
};

type chartState = {
  title: string,
  data: {},
};

export default class Chart extends React.Component {
    props: chartProps;
    state: chartState;
    static propTypes = {
      title: PropTypes.string.isRequired, // this is passed from the Rails view
    };

    /**
     * @param props - Comes from your rails view.
     * @param _railsContext - Comes from React on Rails
     */
    constructor(props: chartProps, railsContext: {}) {
      super(props);
      console.log('ON CONSTRUCTION');

      this.state = {
        title: this.props.title,
        data: this.props.data,
      };
    }

    componentDidMount() {

    }

    updateTitle = (title: string) => {
      this.setState({ title });
    };

    render() {
      return (
        <div>
          <AreaChart id={'users-chart'} data={this.state.data} />
        </div>);
    }
}
