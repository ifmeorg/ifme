/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { Modal } from 'components/Modal';
/* eslint-disable import/no-extraneous-dependencies */
import photo from 'app/assets/images/contributors/ingrid_garcia.jpg';

const title = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';

const bodyText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis commodo erat quis ipsum sodales condimentum. Vestibulum nec posuere lorem. Nulla condimentum, dui et sagittis hendrerit, enim sapien luctus orci, non vehicula nibh massa vel risus. Nunc vitae aliquam lacus. Donec dolor velit, blandit eu erat luctus, aliquam congue augue. Curabitur interdum leo id orci porttitor, eget dictum nibh gravida. Praesent facilisis, justo non convallis consectetur, tellus est egestas erat, quis commodo risus tellus consequat est. Curabitur quis massa non est pharetra mollis. Proin finibus ipsum massa, et semper ipsum ultricies vel. Mauris dignissim auctor egestas. Aenean elit ante, egestas eu ligula a, tincidunt suscipit diam. Nulla ultrices tempus turpis ac cursus. Suspendisse congue sem nec ex vehicula, in vestibulum leo ultricies. Morbi ac faucibus lorem. Donec vitae tellus id quam aliquet iaculis. Nam aliquet quis ante faucibus convallis.';

const longBodyText = `${bodyText} ${bodyText} ${bodyText}`;

const bodyHTML = (
  <>
    <button type="button">Here is a button</button>
    <p>{bodyText}</p>
  </>
);

const openListener = () => {
  window.alert("Hey look it's listening");
};

export default {
  title: 'Components/Modal',
  component: Modal,
};

const Template = (args) => <Modal {...args} />;

export const TextValuesForElementAndBody = Template.bind({});

TextValuesForElementAndBody.args = {
  element: 'Hello',
  body: bodyText,
  title,
};
TextValuesForElementAndBody.storyName = 'Text values for element and body';

export const LongTextValueForcingBodyToScroll = Template.bind({});

LongTextValueForcingBodyToScroll.args = {
  element: 'Hello',
  body: longBodyText,
  title,
};
LongTextValueForcingBodyToScroll.storyName = 'Long text value forcing body to scroll';

export const TextValuesForElementAndBodyWithOpenListener = Template.bind({});

TextValuesForElementAndBodyWithOpenListener.args = {
  element: 'Hello',
  body: bodyText,
  title,
  openListener,
};
TextValuesForElementAndBodyWithOpenListener.storyName = 'Text values for element and body with openListener';

export const HtmlValuesForElementAndBody = Template.bind({});

HtmlValuesForElementAndBody.args = {
  element: <button type="button">Hello</button>,
  body: bodyHTML,
  title,
};
HtmlValuesForElementAndBody.storyName = 'HTML values for element and body';

export const HtmlValuesForElementAndBodyWithOpenListener = Template.bind({});

HtmlValuesForElementAndBodyWithOpenListener.args = {
  element: <button type="button">Hello</button>,
  body: bodyHTML,
  title,
  openListener,
};
HtmlValuesForElementAndBodyWithOpenListener.storyName = 'HTML values for element and body with openListener';

export const AvatarComponentAsTheElement = Template.bind({});

AvatarComponentAsTheElement.args = {
  element: { component: 'Avatar', props: { src: photo, small: true } },
  body: bodyHTML,
  title,
  openListener,
};
AvatarComponentAsTheElement.storyName = 'Avatar component as the element';
