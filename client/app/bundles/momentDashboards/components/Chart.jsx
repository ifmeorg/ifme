// @flow
import 'chart.js';
import PropTypes from 'prop-types';
import React from 'react';
import { AreaChart } from 'react-chartkick';

// const request = require('superagent');

export default class Chart extends React.Component {
    props: {
        title: string,
        data: {},
    };
    state: {
        title: string,
        data: {},
    };
    static propTypes = {
      title: PropTypes.string.isRequired, // this is passed from the Rails view
    };

    /**
     * @param props - Comes from your rails view.
     * @param _railsContext - Comes from React on Rails
     */
    constructor(props, railsContext) {
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
