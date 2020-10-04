// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import { Tag } from 'components/Tag';

const TEST_LABEL = 'TEST_LABEL';
const TEST_URL = 'https://if-me.org';

describe('Tooltip', () => {
  const { getByRole, getByText } = screen;
  test('it renders anchor with normal and href', () => {
    render(<Tag label={TEST_LABEL} normal href={TEST_URL} />);
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(TEST_LABEL)).toBeInTheDocument();
  });
  test('it renders button with normal and onClick', () => {
    render(<Tag label={TEST_LABEL} normal onClick />);
    expect(getByRole('button')).toBeInTheDocument();
    expect(getByText(TEST_LABEL)).toBeInTheDocument();
  });
  test('it renders anchor with dark and href', () => {
    render(<Tag label={TEST_LABEL} dark href={TEST_URL} />);
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(TEST_LABEL)).toBeInTheDocument();
  });
  test('it renders button with dark and onClick', () => {
    render(<Tag label={TEST_LABEL} dark onClick />);
    expect(getByRole('button')).toBeInTheDocument();
    expect(getByText(TEST_LABEL)).toBeInTheDocument();
  });
  test('it renders anchor with secondary and href', () => {
    render(<Tag label={TEST_LABEL} secondary href={TEST_URL} />);
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(TEST_LABEL)).toBeInTheDocument();
  });
  test('it renders button with secondary and onClick', () => {
    render(<Tag label={TEST_LABEL} secondary onClick />);
    expect(getByRole('button')).toBeInTheDocument();
    expect(getByText(TEST_LABEL)).toBeInTheDocument();
  });
});
