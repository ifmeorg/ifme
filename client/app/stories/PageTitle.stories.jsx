/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { PageTitle } from 'components/PageTitle';

export default {
  title: 'Components/PageTitle',
  component: PageTitle,
};

const Template = (args) => <PageTitle {...args} />;

export const WithoutCta = Template.bind({});

WithoutCta.args = { title: 'Title', subtitle: 'Subtitle' };
WithoutCta.storyName = 'Without call to action';

export const WithCta = Template.bind({});

WithCta.args = {
  title: 'Title',
  subtitle: 'Subtitle',
  cta: <button type="button">Hello</button>,
};
WithCta.storyName = 'With call to action';

export const WithInstructions = Template.bind({});

WithInstructions.args = {
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
WithInstructions.storyName = 'With instructions';
