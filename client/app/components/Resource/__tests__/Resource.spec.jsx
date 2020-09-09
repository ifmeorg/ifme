// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import { Resource } from '../index';

const TAGS = [
  'open_source',
  'tech_industry',
  'free',
  'workplace',
  'podcast',
  'books',
];
const TITLE = 'LifeSIGNS: Self Injury Guidance & Network Support (UK)';
const AUTHOR = 'Desi Rottman';
const URL = 'http://www.lifesigns.org.uk/';

describe('Resource', () => {
  const { getByRole, getByText } = screen;
  test('it renders with a title and link', () => {
    render(<Resource title={TITLE} link={URL} />);
    expect(getByText(TITLE)).toBeInTheDocument();
    expect(getByRole('link')).toBeInTheDocument();
  });
  test('it renders with a title, link, and tags', () => {
    render(<Resource title={TITLE} link={URL} tags={TAGS} />);
    expect(getByText(...TAGS));
    expect(getByText(TITLE)).toBeInTheDocument();
    expect(getByRole('link')).toBeInTheDocument();
  });
  test('it renders a title and link with tags={EMPTY_TAGS}', () => {
    render(<Resource title={TITLE} link={URL} />);
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(TITLE)).toBeInTheDocument();
  });
  test('it renders with a title, link, and author', () => {
    render(<Resource title={TITLE} link={URL} author={AUTHOR} />);
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(AUTHOR)).toBeInTheDocument();
    expect(getByText(TITLE)).toBeInTheDocument();
  });
  test('it renders with a title, link tags and author', () => {
    render(<Resource title={TITLE} link={URL} author={AUTHOR} tags={TAGS} />);
    expect(getByText(TITLE)).toBeInTheDocument();
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(...TAGS)).toBeInTheDocument();
    expect(getByText(AUTHOR)).toBeInTheDocument();
  });
});
