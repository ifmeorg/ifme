/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { Toast } from 'components/Toast';

export default {
  title: 'Components/Toast',
  component: Toast,
};

const Template = (args) => <Toast {...args} />;

export const noticeToast = Template.bind({});

noticeToast.args = {
  notice: 'Login successful.',
  appendDashboardClass: 'true',
};
noticeToast.storyName = 'Toast Type: Notice';

export const alertToast = Template.bind({});

alertToast.args = {
  alert: 'Login failed.',
};
alertToast.storyName = 'Toast Type: Alert';
