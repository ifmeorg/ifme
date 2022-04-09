/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { PageTitle } from 'components/PageTitle';

export default {
  title: 'Components/PageTitle',
  component: PageTitle,
};

const Template = (args) => <PageTitle {...args} />;

export const PageTitleWithoutCta = Template.bind({});

PageTitleWithoutCta.args = { title: 'Title', subtitle: 'Subtitle' };
PageTitleWithoutCta.storyName = 'PageTitle without call to action';

export const PageTitleWithCta = Template.bind({});

PageTitleWithCta.args = { title: 'Title', subtitle: 'Subtitle', cta: <button type="button">Hello</button> };
PageTitleWithCta.storyName = 'PageTitle with call to action';

export const PageTitleWithInstructions = Template.bind({});

PageTitleWithInstructions.args = {
  title: 'Title',
  subtitle: 'Subtitle',
  instructions: (
    <>
      These are instructions with a button:
      {' '}
      <button type="button">Hello</button>
    </>
  ),
};
PageTitleWithInstructions.storyName = 'PageTitle with instructions';
