// @flow
import React from 'react';
import { render } from '@testing-library/react';
import { Blockquote } from 'components/Blockquote';

const author = 'Julia Nguyen';
const text = 'Everything is awesome';

describe('Blockquote', () => {
  it('renders correctly', () => {
    const { container } = render(<Blockquote author={author} text={text} />);
    expect(container.firstChild).not.toBeNull();
  });


  it('renders correctly with name prop', () => {
    const component = <Blockquote author={author} text={text} />;
    const { container, queryByText } = render(component);
    const quoteTextSection = container.querySelector('.text');
    expect(container.firstChild).not.toBeNull();
    //console.log(quoteTextSection.innerHTML).toBeInTheDocument();
    expect(queryByText(text)).not.toBeNull();
  });
});
