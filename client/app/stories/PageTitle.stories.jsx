import React from 'react';
import { PageTitle } from 'components/PageTitle';

export default {
  title: 'Components/PageTitle',
};

export const PageTitleWithoutCta = () => (
  <PageTitle title="Title" subtitle="Subtitle" />
);

PageTitleWithoutCta.story = {
  name: 'PageTitle without cta',
};

export const PageTitleWithCta = () => (
  <PageTitle
    title="Title"
    subtitle="Subtitle"
    cta={<button type="button">Hello</button>}
  />
);

PageTitleWithCta.story = {
  name: 'PageTitle with cta',
};

export const PageTitleWithInstructions = () => (
  <PageTitle
    title="Title"
    subtitle="Subtitle"
    instructions={(
      <>
        These are instructions with a button:
        {' '}
        <button type="button">Hello</button>
      </>
    )}
  />
);

PageTitleWithCta.story = {
  name: 'PageTitle with instructions',
};
