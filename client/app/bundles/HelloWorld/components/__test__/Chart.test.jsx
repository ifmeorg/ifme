import React from "react";
import {shallow} from 'enzyme';
var request = require('superagent');

import Chart from '../Chart';

const mockConfig = [
    {
        pattern: '/moments(.*)',
        fixtures: function (match, params, headers, context) {
            if (match[1] === '/analytics') {
                return {"2013-02-10 00:00:00 -0800": 11, "2013-02-11 00:00:00 -0800": 6};
            }
        },
        /**
         * returns the result of the GET request
         *
         * @param match array Result of the resolution of the regular expression
         * @param data  mixed Data returns by `fixtures` attribute
         */
        get: function (match, data) {
            return {
                body: data
            };
        },

        /**
         * returns the result of the POST request
         *
         * @param match array Result of the resolution of the regular expression
         * @param data  mixed Data returns by `fixtures` attribute
         */
        post: function (match, data) {
            return {
                code: 201
            };
        }
    }
]

test('test chart renders', () => {

    // TODO: es6 it
    // var superagentMock = require('superagent-mock')(request, mockConfig);

    const component = shallow(
        <Chart name="test" />
    );


    // superagentMock.unset();
})
