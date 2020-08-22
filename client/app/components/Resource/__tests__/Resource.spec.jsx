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
const EMPTY_TAGS = [];
const TITLE = 'LifeSIGNS: Self Injury Guidance & Network Support (UK)';
const AUTHOR = 'Desi Rottman';
const URL = 'http://www.lifesigns.org.uk/';

describe('Resource', () => {
  const { getByRole, getByText } = screen;
  test('it renders with neither tags nor author', () => {
    render(<Resource title={TITLE} link={URL} />);
    expect(getByText(TITLE)).toBeInTheDocument();
    expect(getByRole('link')).toBeInTheDocument();
  });
  test('it renders with tags={TAGS} and no tagged prop', () => {
    render(<Resource title={TITLE} link={URL} tags={TAGS} />);
    expect(getByText(TITLE)).toBeInTheDocument();
    expect(getByRole('link')).toBeInTheDocument();
  });
  test('it renders with tagged and tags={TAGS}', () => {
    render(<Resource title={TITLE} link={URL} tagged tags={TAGS} />);
    expect(getByText(...TAGS));
    expect(getByText(TITLE)).toBeInTheDocument();
    expect(getByRole('link')).toBeInTheDocument();
  });
  test('it renders with tags={EMPTY_TAGS} and no author ', () => {
    render(<Resource title={TITLE} link={URL} tagged tags={EMPTY_TAGS} />);
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(TITLE)).toBeInTheDocument();
  });
  test('it renders with external and author={AUTHOR}', () => {
    render(<Resource title={TITLE} link={URL} external author={AUTHOR} />);
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(AUTHOR)).toBeInTheDocument();
    expect(getByText(TITLE)).toBeInTheDocument();
  });
  test('it renders with external tagged', () => {
    render(<Resource title={TITLE} link={URL} external tagged />);
    expect(getByText(TITLE)).toBeInTheDocument();
    expect(getByRole('link')).toBeInTheDocument();
  });
  test('it renders with external, tagged, and author={AUTHOR}', () => {
    render(
      <Resource title={TITLE} link={URL} external author={AUTHOR} tagged />,
    );
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(TITLE)).toBeInTheDocument();
    expect(getByText(AUTHOR)).toBeInTheDocument();
  });
  test('it renders with external, tags={TAGS}, tagged, and author={AUTHOR}', () => {
    render(
      <Resource
        title={TITLE}
        link={URL}
        external
        author={AUTHOR}
        tagged
        tags={TAGS}
      />,
    );
    expect(getByText(...TAGS)).toBeInTheDocument();
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(TITLE)).toBeInTheDocument();
    expect(getByText(AUTHOR)).toBeInTheDocument();
  });
  test('it renders with external, tags={EMPTY_TAGS}, tagged and author={AUTHOR}', () => {
    render(
      <Resource
        title={TITLE}
        link={URL}
        external
        author={AUTHOR}
        tagged
        tags={EMPTY_TAGS}
      />,
    );
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(TITLE)).toBeInTheDocument();
    expect(getByText(AUTHOR)).toBeInTheDocument();
  });
  test('it renders with external, tagged, and tags={TAGS}', () => {
    render(<Resource title={TITLE} link={URL} external tagged tags={TAGS} />);
    expect(getByText(...TAGS)).toBeInTheDocument();
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(TITLE)).toBeInTheDocument();
  });
  test('it renders with external, tagged, and tags={EMPTY_TAGS}', () => {
    render(
      <Resource title={TITLE} link={URL} external tagged tags={EMPTY_TAGS} />,
    );
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(TITLE)).toBeInTheDocument();
  });
});
