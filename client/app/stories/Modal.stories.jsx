import React from 'react';
import { storiesOf } from '@storybook/react';
import { Modal } from '../components/Modal';
import photoTara from '../../../app/assets/images/contributors/tara_swenson.jpg';

const title = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';

const bodyText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis commodo erat quis ipsum sodales condimentum. Vestibulum nec posuere lorem. Nulla condimentum, dui et sagittis hendrerit, enim sapien luctus orci, non vehicula nibh massa vel risus. Nunc vitae aliquam lacus. Donec dolor velit, blandit eu erat luctus, aliquam congue augue. Curabitur interdum leo id orci porttitor, eget dictum nibh gravida. Praesent facilisis, justo non convallis consectetur, tellus est egestas erat, quis commodo risus tellus consequat est. Curabitur quis massa non est pharetra mollis. Proin finibus ipsum massa, et semper ipsum ultricies vel. Mauris dignissim auctor egestas. Aenean elit ante, egestas eu ligula a, tincidunt suscipit diam. Nulla ultrices tempus turpis ac cursus. Suspendisse congue sem nec ex vehicula, in vestibulum leo ultricies. Morbi ac faucibus lorem. Donec vitae tellus id quam aliquet iaculis. Nam aliquet quis ante faucibus convallis.';

const longBodyText = `${bodyText} ${bodyText} ${bodyText}`;

const bodyHTML = (
  <div>
    <button type="button">Here is a button</button>
    <p>{bodyText}</p>
  </div>
);

const openListener = () => {
  window.alert("Hey look it's listening");
};

storiesOf('Modal', module)
  .add('Text values for element and body', () => (
    <Modal element="Hello" body={bodyText} title={title} />
  ))
  .add('Long text value forcing body to scroll', () => (
    <Modal element="Hello" body={longBodyText} title={title} />
  ))
  .add('Text values for element and body with openListener', () => (
    <Modal
      element="Hello"
      body={bodyText}
      title={title}
      openListener={openListener}
    />
  ))
  .add('HTML values for element and body', () => (
    <Modal
      element={<button type="button">Hello</button>}
      body={bodyHTML}
      title={title}
    />
  ))
  .add('HTML values for element and body with openListener', () => (
    <Modal
      element={<button type="button">Hello</button>}
      body={bodyHTML}
      title={title}
      openListener={openListener}
    />
  ))
  .add('Avatar component as the element', () => (
    <Modal
      element={{ component: 'Avatar', props: { src: photoTara, small: true } }}
      body={bodyHTML}
      title={title}
      openListener={openListener}
    />
  ));
