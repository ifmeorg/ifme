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
      const { container, queryByText } = render(<Blockquote text={text} />);
      const textSection = container.querySelector('.text');
      expect(container).not.toBeNull();
      expect(container.firstChild).not.toBeNull();
      expect(textSection).toBeInTheDocument();
      expect(queryByText(text)).not.toBeNull();
    });
  });

  describe('has author prop', () => {
    it('renders correctly with author prop', () => {
      const { container, queryByText } = render(<Blockquote author={author} />);
      const authorSection = container.querySelector('.author');
      expect(container.firstChild).not.toBeNull();
      expect(authorSection).toBeInTheDocument();
      expect(queryByText(author)).not.toBeNull();
    });
  });

  describe('has text and author props', () => {
    it('renders correctly with author prop', () => {
      const { container, queryByText } = render(<Blockquote text={text} author={author} />);
      expect(container.firstChild).not.toBeNull();
      
      const textSection = container.querySelector('.text');
      expect(textSection).toBeInTheDocument();
      expect(queryByText(text)).not.toBeNull();

      const authorSection = container.querySelector('.author');
      expect(authorSection).toBeInTheDocument();
      expect(queryByText(author)).not.toBeNull();
    });
  });
});
