// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import { faQuestion } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { Tooltip } from 'components/Tooltip';

describe('Tooltip', () => {
  const { getByRole, getByText } = screen;
  test('Element is text / default position', () => {
    render(<Tooltip element="Hello" text="Some text" />);
    expect(getByRole('tooltip')).toBeInTheDocument();
  });
  test('Element is html / default position', () => {
    render(<Tooltip element={<div>hello</div>} text="Some text" />);
    expect(getByRole('tooltip')).toBeInTheDocument();
    expect(getByText('Some text')).toBeInTheDocument();
  });
  test('Element is FontAwsomeIcon / center position', () => {
    render(
      <Tooltip
        element={<FontAwesomeIcon icon={faQuestion} />}
        text="Some text"
        center
      />,
    );
    expect(getByRole('tooltip')).toBeInTheDocument();
    expect(getByText('Some text')).toBeInTheDocument();
  });
  test('Element is text / right position', () => {
    render(<Tooltip element="hello" text="Some text" right />);
    expect(getByRole('tooltip')).toBeInTheDocument();
    expect(getByRole('tooltip')).toHaveClass('tooltipRight');
    expect(getByText('Some text')).toBeInTheDocument();
  });
  test('Element is html / right position', () => {
    render(<Tooltip element={<div>hello</div>} text="Some text" right />);
    expect(getByRole('tooltip')).toBeInTheDocument();
    expect(getByRole('tooltip')).toHaveClass('tooltipRight');
    expect(getByText('Some text')).toBeInTheDocument();
  });
  test('Element is FontAwsomeIcon / center position', () => {
    render(
      <Tooltip
        element={<FontAwesomeIcon icon={faQuestion} />}
        text="Some text"
        right
      />,
    );
    expect(getByRole('tooltip')).toBeInTheDocument();
    expect(getByRole('tooltip')).toHaveClass('tooltipRight');
    expect(getByText('Some text')).toBeInTheDocument();
  });
  test('Element is text / center position', () => {
    render(<Tooltip element="hello" text="Some text" center />);
    expect(getByRole('tooltip')).toBeInTheDocument();
    expect(getByRole('tooltip')).toHaveClass('tooltipCenter');
    expect(getByText('Some text')).toBeInTheDocument();
  });
  test('Element is html / center position', () => {
    render(<Tooltip element={<div>hello</div>} text="Some text" center />);
    expect(getByRole('tooltip')).toBeInTheDocument();
    expect(getByRole('tooltip')).toHaveClass('tooltipCenter');
    expect(getByText('Some text')).toBeInTheDocument();
  });
  test('Element is FontAwsomeIcon / center position', () => {
    render(
      <Tooltip
        element={<FontAwesomeIcon icon={faQuestion} />}
        text="Some text"
        center
      />,
    );
    expect(getByRole('tooltip')).toBeInTheDocument();
    expect(getByRole('tooltip')).toHaveClass('tooltipCenter');
    expect(getByText('Some text')).toBeInTheDocument();
  });
});
