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
  const {
    getByRole, getByText, getByTestId, queryByTestId,
  } = screen;
  test('it renders with neither tags nor author', () => {
    render(<Resource title={TITLE} link={URL} />);
    expect(getByTestId('resource-div')).toBeInTheDocument();
    expect(queryByTestId('author-div')).toBeNull();
    expect(queryByTestId('tags-div')).toBeNull();
    expect(getByText(TITLE)).toBeInTheDocument();
    expect(getByRole('link')).toBeInTheDocument();
  });
  test('it renders when given tags with no tagged prop', () => {
    render(<Resource title={TITLE} link={URL} tags={TAGS} />);
    expect(getByTestId('resource-div')).toBeInTheDocument();
    expect(queryByTestId('author-div')).toBeNull();
    expect(queryByTestId('tags-div')).toBeNull();
    expect(getByText(TITLE)).toBeInTheDocument();
    expect(getByRole('link')).toBeInTheDocument();
  });
  test('it renders with only tags={TAGS}', () => {
    render(<Resource title={TITLE} link={URL} tagged tags={TAGS} />);
    expect(getByTestId('resource-div')).toBeInTheDocument();
    expect(getByTestId('tags-div')).toBeInTheDocument();
    expect(getByTestId('tags-div')).toHaveTextContent(...TAGS);
    expect(getByText(TITLE)).toBeInTheDocument();
    expect(getByRole('link')).toBeInTheDocument();
  });
  test('it renders with tags={EMPTY_TAGS} and no author ', () => {
    render(<Resource title={TITLE} link={URL} tagged tags={EMPTY_TAGS} />);
    expect(getByTestId('resource-div')).toBeInTheDocument();
    expect(queryByTestId('tags-div')).toBeInTheDocument();
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(TITLE)).toBeInTheDocument();
  });
  test('it renders with external and author={AUTHOR}', () => {
    render(<Resource title={TITLE} link={URL} external author={AUTHOR} />);
    expect(getByTestId('resource-div')).toBeInTheDocument();
    expect(getByTestId('author-div')).toBeInTheDocument();
    expect(queryByTestId('tags-div')).toBeNull();
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByTestId('author-div')).toHaveTextContent(AUTHOR);
    expect(getByText(TITLE)).toBeInTheDocument();
  });
  test('it renders with external tagged', () => {
    render(<Resource title={TITLE} link={URL} external tagged />);
    expect(getByTestId('resource-div')).toBeInTheDocument();
    expect(getByTestId('tags-div')).toBeInTheDocument();
    expect(getByText(TITLE)).toBeInTheDocument();
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByTestId('author-div')).toHaveClass('author');
    expect(getByTestId('author-div')).toHaveTextContent('');
  });
  test('it renders with external, tagged and author={AUTHOR}', () => {
    render(
      <Resource title={TITLE} link={URL} external author={AUTHOR} tagged />,
    );
    expect(getByTestId('resource-div')).toBeInTheDocument();
    expect(getByTestId('tags-div')).toHaveClass('tags');
    expect(getByTestId('author-div')).toHaveClass('author');
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
    expect(getByTestId('resource-div')).toBeInTheDocument();
    expect(getByTestId('tags-div')).toHaveClass('tags');
    expect(getByTestId('tags-div')).toHaveTextContent(...TAGS);
    expect(getByTestId('author-div')).toHaveClass('author');
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
    expect(getByTestId('resource-div')).toBeInTheDocument();
    expect(getByTestId('tags-div')).toHaveClass('tags');
    expect(getByTestId('tags-div')).toHaveTextContent('');
    expect(getByTestId('author-div')).toHaveClass('author');
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(TITLE)).toBeInTheDocument();
    expect(getByText(AUTHOR)).toBeInTheDocument();
  });
  test('it renders with external, tagged, and tags={TAGS}', () => {
    render(<Resource title={TITLE} link={URL} external tagged tags={TAGS} />);
    expect(getByTestId('resource-div')).toBeInTheDocument();
    expect(getByTestId('tags-div')).toHaveClass('tags');
    expect(getByTestId('tags-div')).toHaveTextContent(...TAGS);
    expect(getByTestId('author-div')).toHaveClass('author');
    expect(getByTestId('author-div')).toHaveTextContent('');
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(TITLE)).toBeInTheDocument();
  });
  test('it renders with external, tagged, and tags={EMPTY_TAGS}', () => {
    render(
      <Resource title={TITLE} link={URL} external tagged tags={EMPTY_TAGS} />,
    );
    expect(getByTestId('resource-div')).toBeInTheDocument();
    expect(getByTestId('tags-div')).toHaveClass('tags');
    expect(getByTestId('tags-div')).toHaveTextContent('');
    expect(getByTestId('author-div')).toHaveClass('author');
    expect(getByTestId('author-div')).toHaveTextContent('');
    expect(getByRole('link')).toBeInTheDocument();
    expect(getByText(TITLE)).toBeInTheDocument();
  });
});
