// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import { Avatar } from 'components/Avatar';

const name = 'Julia Nguyen';
const src = '/some-img-url';

describe('Avatar', () => {
  describe('has src prop', () => {
    it('renders correctly', () => {
      render(<Avatar src={src} />);
      expect(screen).not.toBeNull();
    });

    it('renders correctly with name prop', () => {
      const component = <Avatar src={src} name={name} />;
      const { container, queryByText } = render(component);
      const nameSection = container.querySelector('.name');
      expect(container.firstChild).not.toBeNull();
      expect(nameSection).toBeInTheDocument();
      expect(queryByText(name)).not.toBeNull();
    });
  });

  describe('has no src prop', () => {
    it('renders correctly', () => {
      const { container } = render(<Avatar />);
      expect(container.firstChild).not.toBeNull();
    });

    it('renders correctly with name prop', () => {
      const { container, queryByText } = render(<Avatar name={name} />);
      const nameSection = container.querySelector('.name');
      expect(container.firstChild).not.toBeNull();
      expect(nameSection).toBeInTheDocument();
      expect(queryByText(name)).not.toBeNull();
    });
  });
});
