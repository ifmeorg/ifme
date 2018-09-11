// @flow
import { render, shallow } from 'enzyme';
import React from 'react';
import { Modal } from '../index';

const title = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';

const bodyText =
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis commodo erat quis ipsum sodales condimentum. Vestibulum nec posuere lorem. Nulla condimentum, dui et sagittis hendrerit, enim sapien luctus orci, non vehicula nibh massa vel risus. Nunc vitae aliquam lacus. Donec dolor velit, blandit eu erat luctus, aliquam congue augue. Curabitur interdum leo id orci porttitor, eget dictum nibh gravida. Praesent facilisis, justo non convallis consectetur, tellus est egestas erat, quis commodo risus tellus consequat est. Curabitur quis massa non est pharetra mollis. Proin finibus ipsum massa, et semper ipsum ultricies vel. Mauris dignissim auctor egestas. Aenean elit ante, egestas eu ligula a, tincidunt suscipit diam. Nulla ultrices tempus turpis ac cursus. Suspendisse congue sem nec ex vehicula, in vestibulum leo ultricies. Morbi ac faucibus lorem. Donec vitae tellus id quam aliquet iaculis. Nam aliquet quis ante faucibus convallis.';

const bodyHTML = (
  <div>
    <button>Here is a button</button>
    <p>{bodyText}</p>
  </div>
);

const openListener = () => {
  window.alert("Hey look it's listening");
};

describe('Modal', () => {
  beforeAll(() => {
    spyOn(window, 'alert');
  });

  describe('Text values for element and body', () => {
    const component = <Modal element="Hello" body={bodyText} title={title} />;

    it('renders correctly', () => {
      let wrapper = null;
      expect(() => {
        wrapper = render(component);
      }).not.toThrow();
      expect(wrapper).not.toBeNull();
    });

    it('toggles correctly', () => {
      const wrapper = shallow(component);
      expect(wrapper.find('#modalBackdrop').length).toEqual(0);
      expect(wrapper.find('#modal').length).toEqual(0);
      wrapper.find('.modalElement').simulate('click');
      expect(wrapper.find('#modalBackdrop').length).toEqual(1);
      expect(wrapper.find('#modal').length).toEqual(1);
      wrapper.find('.modalElement').simulate('click');
      expect(wrapper.find('#modalBackdrop').length).toEqual(0);
      expect(wrapper.find('#modal').length).toEqual(0);
    });
  });

  describe('Text values for element and body with openListener', () => {
    const component = (
      <Modal
        element="Hello"
        body={bodyText}
        title={title}
        openListener={() => openListener()}
      />
    );

    it('renders correctly', () => {
      let wrapper = null;
      expect(() => {
        wrapper = render(component);
      }).not.toThrow();
      expect(wrapper).not.toBeNull();
    });

    it('toggles correctly', () => {
      const wrapper = shallow(component);
      expect(wrapper.find('#modalBackdrop').length).toEqual(0);
      expect(wrapper.find('#modal').length).toEqual(0);
      wrapper.find('.modalElement').simulate('click');
      expect(window.alert).toHaveBeenCalled();
      expect(wrapper.find('#modalBackdrop').length).toEqual(1);
      expect(wrapper.find('#modal').length).toEqual(1);
      wrapper.find('.modalElement').simulate('click');
      expect(window.alert).toHaveBeenCalled();
      expect(wrapper.find('#modalBackdrop').length).toEqual(0);
      expect(wrapper.find('#modal').length).toEqual(0);
    });
  });

  describe('HTML values for element and body', () => {
    const component = (
      <Modal element={<button>Hello</button>} body={bodyHTML} title={title} />
    );

    it('renders correctly', () => {
      let wrapper = null;
      expect(() => {
        wrapper = render(component);
      }).not.toThrow();
      expect(wrapper).not.toBeNull();
    });

    it('toggles correctly', () => {
      const wrapper = shallow(component);
      expect(wrapper.find('#modalBackdrop').length).toEqual(0);
      expect(wrapper.find('#modal').length).toEqual(0);
      wrapper.find('.modalElement').simulate('click');
      expect(wrapper.find('#modalBackdrop').length).toEqual(1);
      expect(wrapper.find('#modal').length).toEqual(1);
      wrapper.find('.modalElement').simulate('click');
      expect(wrapper.find('#modalBackdrop').length).toEqual(0);
      expect(wrapper.find('#modal').length).toEqual(0);
    });
  });

  describe('HTML values for element and body with openListener', () => {
    const component = (
      <Modal
        element={<button>Hello</button>}
        body={bodyHTML}
        title={title}
        openListener={() => openListener()}
      />
    );

    it('renders correctly', () => {
      let wrapper = null;
      expect(() => {
        wrapper = render(component);
      }).not.toThrow();
      expect(wrapper).not.toBeNull();
    });

    it('toggles correctly', () => {
      const wrapper = shallow(component);
      expect(wrapper.find('#modalBackdrop').length).toEqual(0);
      expect(wrapper.find('#modal').length).toEqual(0);
      wrapper.find('.modalElement').simulate('click');
      expect(window.alert).toHaveBeenCalled();
      expect(wrapper.find('#modalBackdrop').length).toEqual(1);
      expect(wrapper.find('#modal').length).toEqual(1);
      wrapper.find('.modalElement').simulate('click');
      expect(window.alert).toHaveBeenCalled();
      expect(wrapper.find('#modalBackdrop').length).toEqual(0);
      expect(wrapper.find('#modal').length).toEqual(0);
    });
  });
});
