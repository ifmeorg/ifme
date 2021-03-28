// @flow
import { render, screen } from '@testing-library/react';

import { Blockquote } from 'components/Blockquote';
import React from 'react';

const text = 'Quisque sit amet nulla sed erat tempus efficitur a id.';
const author = 'Nullam ante';

describe('Blockquote', () => {
  describe('has no props', () => {
    it('renders correctly', () => {
      render(<Blockquote />);
      expect(screen).not.toBeNull();
    });
  });

  describe('has text prop', () => {
    it('renders correctly with text prop', () => {
      const { queryByText } = render(<Blockquote text={text} />);
      expect(queryByText(text)).toBeInTheDocument();
    });
  });

  describe('has author prop', () => {
    it('renders correctly with author prop', () => {
      const { queryByText } = render(<Blockquote author={author} />);
      expect(queryByText(author)).toBeInTheDocument();
    });
  });

  describe('has text and author props', () => {
    it('renders correctly with author prop', () => {
      const { queryByText } = render(
        <Blockquote text={text} author={author} />,
      );
      expect(queryByText(text)).toBeInTheDocument();
      expect(queryByText(author)).toBeInTheDocument();
    });
  });
});
