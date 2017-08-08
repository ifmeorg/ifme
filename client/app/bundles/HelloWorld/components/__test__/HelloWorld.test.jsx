import React from 'react';
import HelloWorld from '../HelloWorld';
import renderer from 'react-test-renderer';

test('test helloworld renders', () => {

    const component = renderer.create(
        <HelloWorld name="foo" />
    )

    let tree = component.toJSON();
    expect(tree).toMatchSnapshot();

});
