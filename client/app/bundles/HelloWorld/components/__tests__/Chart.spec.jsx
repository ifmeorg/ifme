import React from 'react';
import Chart from '../Chart';
import { render } from 'enzyme';

describe('Chart', () => {
    it("renders a Chart", () => {
        expect(() => {
            render(<Chart />);
        }).not.toThrow();
    });
});
