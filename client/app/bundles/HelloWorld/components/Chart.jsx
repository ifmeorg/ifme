import PropTypes from 'prop-types';
import React from 'react';
import { AreaChart } from 'react-chartkick';
import "chartjs";

// const request = require('superagent');

export default class Chart extends React.Component {
    static propTypes = {
        name: PropTypes.string.isRequired, // this is passed from the Rails view
    };

    /**
     * @param props - Comes from your rails view.
     * @param _railsContext - Comes from React on Rails
     */
    constructor(props, railsContext) {
        super(props);
        console.log('ON CONSTRUCTION');

        // How to set initial state in ES6 class syntax
        // https://facebook.github.io/react/docs/reusable-components.html#es6-classes
        this.state = { name: this.props.name, data: null };
    }

    componentDidMount() {
        console.log('COMPONENT DID MOUNT');
        // request
        //     .get('/moments/analytics')
        //     .end(function(err, res){
        //         if (err === null && res) {
        //             console.log('it works!')
        //             this.setState({ data: res })
        //         }
        //     });
    }


    updateName = (name) => {
        this.setState({ name });
    };

    render() {
        return (
            <div>
                <h1> I AM CHART </h1>
                <AreaChart data={{"2013-02-10 00:00:00 -0800": 11, "2013-02-11 00:00:00 -0800": 6}} />
            </div>);
    }
}
