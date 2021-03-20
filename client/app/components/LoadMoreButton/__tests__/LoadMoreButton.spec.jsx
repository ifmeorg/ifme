// @flow
import { render, screen } from '@testing-library/react';

import { I18n } from 'libs/i18n';
import { LoadMoreButton } from 'components/LoadMoreButton';
import React from 'react';
import userEvent from '@testing-library/user-event';

const onClick = jest.fn();

describe('LoadMoreButton', () => {
  describe('has no props', () => {
    it('renders correctly', () => {
      const { container, queryByText } = render(<LoadMoreButton />);
      expect(container).not.toBeNull();
      expect(queryByText(I18n.t('load_more'))).toBeInTheDocument();
    });
  });

  describe('has onClick prop', () => {
    it('renders correctly', () => {
      render(<LoadMoreButton onClick={onClick} />);
      expect(screen).not.toBeNull();
    });

    it('triggers function passed in through onClick prop when button is clicked', () => {
      const { queryByRole } = render(<LoadMoreButton onClick={onClick} />);
      const button = queryByRole('button');
      expect(button).toBeInTheDocument();
      userEvent.click(button);
      expect(onClick).toHaveBeenCalledTimes(1);
    });
  });
});
