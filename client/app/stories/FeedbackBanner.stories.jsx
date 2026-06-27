/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { action } from '@storybook/addon-actions';
import { FeedbackBanner } from 'components/FeedbackBanner';

export default {
  title: 'Components/FeedbackBanner',
  component: FeedbackBanner,
  parameters: {
    backgrounds: { default: 'mulberry' },
  },
};

const Template = (args) => <FeedbackBanner {...args} />;

export const autosaveDraft = Template.bind({});
autosaveDraft.args = {
  message: 'You have an unsaved draft from 5 minutes ago. Would you like to restore it?',
  actions: [
    { label: 'Restore draft', onClick: action('onRestore'), primary: true },
    { label: 'Dismiss', onClick: action('onDismiss') },
  ],
};
autosaveDraft.storyName = 'Autosave: Restore Draft';

export const singleAction = Template.bind({});
singleAction.args = {
  message: 'Your changes have been saved.',
  actions: [
    { label: 'OK', onClick: action('onOK'), primary: true },
  ],
};
singleAction.storyName = 'Single Action';

export const infoMessage = Template.bind({});
infoMessage.args = {
  message: 'You are viewing a read-only version of this entry.',
  actions: [
    { label: 'Go back', onClick: action('onGoBack') },
    { label: 'Edit', onClick: action('onEdit'), primary: true },
  ],
};
infoMessage.storyName = 'Info with Multiple Actions';
