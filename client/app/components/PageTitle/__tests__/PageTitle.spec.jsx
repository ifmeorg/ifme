// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import { PageTitle } from 'components/PageTitle';

const TITLE = 'title';
const SUBTITLE = 'subtitle';
const CTA_TEXT = 'cta';
const INSTRUCTIONS = 'instructions';

describe('PageTitle', () => {
  it('renders with title and subtitle', () => {
    render(<PageTitle title={TITLE} subtitle={SUBTITLE} />);
    expect(screen.getByText(TITLE)).toBeInTheDocument();
    expect(screen.getByText(SUBTITLE)).toBeInTheDocument();
    expect(window.document.title).toEqual(`if-me.org | ${TITLE}`);
  });

  it('renders with title, subtitle, and cta', () => {
    render(
      <PageTitle
        title={TITLE}
        subtitle={SUBTITLE}
        cta={<button type="button">{CTA_TEXT}</button>}
      />,
    );
    expect(screen.getByText(TITLE)).toBeInTheDocument();
    expect(screen.getByText(SUBTITLE)).toBeInTheDocument();
    expect(window.document.title).toEqual(`if-me.org | ${TITLE}`);
    expect(screen.getByText(CTA_TEXT)).toBeInTheDocument();
  });

  it('renders with title, subtitle, cta, and instructions', () => {
    render(
      <PageTitle
        title={TITLE}
        subtitle={SUBTITLE}
        cta={<button type="button">{CTA_TEXT}</button>}
        instructions={INSTRUCTIONS}
      />,
    );
    expect(screen.getByText(TITLE)).toBeInTheDocument();
    expect(screen.getByText(SUBTITLE)).toBeInTheDocument();
    expect(window.document.title).toEqual(`if-me.org | ${TITLE}`);
    expect(screen.getByText(CTA_TEXT)).toBeInTheDocument();
    expect(screen.getByText(INSTRUCTIONS)).toBeInTheDocument();
  });
});
