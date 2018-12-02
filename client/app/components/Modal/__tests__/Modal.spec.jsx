// @flow
import { shallow, mount } from 'enzyme';
import React from 'react';
import { Modal } from '../index';

const title = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';

const bodyText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis commodo erat quis ipsum sodales condimentum. Vestibulum nec posuere lorem. Nulla condimentum, dui et sagittis hendrerit, enim sapien luctus orci, non vehicula nibh massa vel risus. Nunc vitae aliquam lacus. Donec dolor velit, blandit eu erat luctus, aliquam congue augue. Curabitur interdum leo id orci porttitor, eget dictum nibh gravida. Praesent facilisis, justo non convallis consectetur, tellus est egestas erat, quis commodo risus tellus consequat est. Curabitur quis massa non est pharetra mollis. Proin finibus ipsum massa, et semper ipsum ultricies vel. Mauris dignissim auctor egestas. Aenean elit ante, egestas eu ligula a, tincidunt suscipit diam. Nulla ultrices tempus turpis ac cursus. Suspendisse congue sem nec ex vehicula, in vestibulum leo ultricies. Morbi ac faucibus lorem. Donec vitae tellus id quam aliquet iaculis. Nam aliquet quis ante faucibus convallis.';

const bodyHTML = (
  <div>
    <button type="button">Here is a button</button>
    <p>{bodyText}</p>
  </div>
);

const openListener = () => {
  window.alert("Hey look it's listening");
};

describe('Modal', () => {
  beforeEach(() => {
    jest.spyOn(window, 'alert');
  });

  describe('has open prop as false', () => {
    describe('has text values for element and body', () => {
      const component = <Modal element="Hello" body={bodyText} title={title} />;
      it('toggles correctly', () => {
        const wrapper = shallow(component);
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(false);
        expect(wrapper.find('.modal').exists()).toEqual(false);
        wrapper.find('.modalElement').simulate('click');
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(true);
        expect(wrapper.find('.modal').exists()).toEqual(true);
        wrapper.find('.modalClose').simulate('click');
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(false);
        expect(wrapper.find('.modal').exists()).toEqual(false);
      });
    });

    describe('has text values for element and body with openListener', () => {
      it('toggles correctly', () => {
        const component = (
          <Modal
            element="Hello"
            body={bodyText}
            title={title}
            openListener={openListener}
          />
        );
        const wrapper = shallow(component);
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(false);
        expect(wrapper.find('.modal').exists()).toEqual(false);
        wrapper.find('.modalElement').simulate('click');
        expect(window.alert).toHaveBeenCalled();
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(true);
        expect(wrapper.find('.modal').exists()).toEqual(true);
        wrapper.find('.modalClose').simulate('click');
        expect(window.alert).toHaveBeenCalled();
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(false);
        expect(wrapper.find('.modal').exists()).toEqual(false);
      });
    });

    describe('has HTML values for element and body', () => {
      it('toggles correctly', () => {
        const component = (
          <Modal
            element={<button type="button">Hello</button>}
            body={bodyHTML}
            title={title}
          />
        );
        const wrapper = shallow(component);
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(false);
        expect(wrapper.find('.modal').exists()).toEqual(false);
        wrapper.find('.modalElement').simulate('click');
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(true);
        expect(wrapper.find('.modal').exists()).toEqual(true);
        wrapper.find('.modalClose').simulate('click');
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(false);
        expect(wrapper.find('.modal').exists()).toEqual(false);
      });
    });

    describe('has HTML values for element and body with openListener', () => {
      it('toggles correctly', () => {
        const component = (
          <Modal
            element={<button type="button">Hello</button>}
            body={bodyHTML}
            title={title}
            openListener={openListener}
          />
        );
        const wrapper = shallow(component);
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(false);
        expect(wrapper.find('.modal').exists()).toEqual(false);
        wrapper.find('.modalElement').simulate('click');
        expect(window.alert).toHaveBeenCalled();
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(true);
        expect(wrapper.find('.modal').exists()).toEqual(true);
        wrapper.find('.modalClose').simulate('click');
        expect(window.alert).toHaveBeenCalled();
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(false);
        expect(wrapper.find('.modal').exists()).toEqual(false);
      });
    });
  });

  describe('has open prop as true', () => {
    describe('has text values for element and body', () => {
      const component = (
        <Modal element="Hello" body={bodyText} title={title} open />
      );
      it('toggles correctly', () => {
        const wrapper = shallow(component);
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(true);
        expect(wrapper.find('.modal').exists()).toEqual(true);
        wrapper.find('.modalClose').simulate('click');
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(false);
        expect(wrapper.find('.modal').exists()).toEqual(false);
        wrapper.find('.modalElement').simulate('click');
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(true);
        expect(wrapper.find('.modal').exists()).toEqual(true);
      });
    });

    describe('has text values for element and body with openListener', () => {
      it('toggles correctly', () => {
        const component = (
          <Modal
            element="Hello"
            body={bodyText}
            title={title}
            openListener={openListener}
            open
          />
        );
        const wrapper = shallow(component);
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(true);
        expect(wrapper.find('.modal').exists()).toEqual(true);
        wrapper.find('.modalClose').simulate('click');
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(false);
        expect(wrapper.find('.modal').exists()).toEqual(false);
        wrapper.find('.modalElement').simulate('click');
        expect(window.alert).toHaveBeenCalled();
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(true);
        expect(wrapper.find('.modal').exists()).toEqual(true);
      });
    });

    describe('has HTML values for element and body', () => {
      it('toggles correctly', () => {
        const component = (
          <Modal
            element={<button type="button">Hello</button>}
            body={bodyHTML}
            title={title}
            open
          />
        );
        const wrapper = shallow(component);
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(true);
        expect(wrapper.find('.modal').exists()).toEqual(true);
        wrapper.find('.modalClose').simulate('click');
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(false);
        expect(wrapper.find('.modal').exists()).toEqual(false);
        wrapper.find('.modalElement').simulate('click');
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(true);
        expect(wrapper.find('.modal').exists()).toEqual(true);
      });
    });

    describe('has HTML values for element and body with openListener', () => {
      it('toggles correctly', () => {
        const component = (
          <Modal
            element={<button type="button">Hello</button>}
            body={bodyHTML}
            title={title}
            openListener={openListener}
            open
          />
        );
        const wrapper = shallow(component);
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(true);
        expect(wrapper.find('.modal').exists()).toEqual(true);
        wrapper.find('.modalClose').simulate('click');
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(false);
        expect(wrapper.find('.modal').exists()).toEqual(false);
        wrapper.find('.modalElement').simulate('click');
        expect(window.alert).toHaveBeenCalled();
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(true);
        expect(wrapper.find('.modal').exists()).toEqual(true);
      });
    });

    describe('uses an Avatar component for an element and HTML values for the body', () => {
      it('renders correctly', () => {
        const component = (
          <Modal
            element={{
              component: 'Avatar',
              props: { src: 'https://via.placeholder.com/75x75' },
            }}
            body={bodyHTML}
            title={title}
          />
        );

        const wrapper = mount(component);
        expect(wrapper.find('.avatar').exists()).toEqual(true);
        wrapper.find('.avatar').simulate('click');
        expect(wrapper.find('.modalBackdrop').exists()).toEqual(true);
        expect(wrapper.find('.modal').exists()).toEqual(true);
      });
    });
  });
});
