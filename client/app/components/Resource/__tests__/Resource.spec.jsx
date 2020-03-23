// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { Resource } from '../index';

const TAGS = [
  'open_source',
  'tech_industry',
  'free',
  'workplace',
  'podcast',
  'books',
];
const EMPTY_TAGS = [];
const TITLE = 'LifeSIGNS: Self Injury Guidance & Network Support (UK)';
const AUTHOR = 'Desi Rottman';
const URL = 'http://www.lifesigns.org.uk/';

describe('Resource', () => {
  it('renders with neither tags nor author', () => {
    let wrapper = shallow(<Resource title={TITLE} link={URL} />);
    expect(wrapper.find('.author').exists()).toEqual(false);
    expect(wrapper.find('.tags').exists()).toEqual(false);

    wrapper = shallow(<Resource title={TITLE} link={URL} tags={TAGS} />);
    expect(wrapper.find('.author').exists()).toEqual(false);
    expect(wrapper.find('.tags').exists()).toEqual(false);

    wrapper = shallow(<Resource title={TITLE} link={URL} author={AUTHOR} />);
    expect(wrapper.find('.author').exists()).toEqual(false);
    expect(wrapper.find('.tags').exists()).toEqual(false);

    wrapper = shallow(
      <Resource title={TITLE} link={URL} tags={TAGS} author={AUTHOR} />,
    );
    expect(wrapper.find('.author').exists()).toEqual(false);
    expect(wrapper.find('.tags').exists()).toEqual(false);
  });

  it('renders with only tags', () => {
    let wrapper = shallow(
      <Resource title={TITLE} link={URL} tagged tags={TAGS} />,
    );
    expect(wrapper.find('.author').exists()).toEqual(false);
    expect(wrapper.find('.tags').exists()).toEqual(true);
    expect(wrapper.find('Tag').length).toEqual(TAGS.length);

    wrapper = shallow(
      <Resource title={TITLE} link={URL} tagged tags={EMPTY_TAGS} />,
    );
    expect(wrapper.find('.author').exists()).toEqual(false);
    expect(wrapper.find('.tags').exists()).toEqual(true);
    expect(wrapper.find('Tag').length).toEqual(0);
  });

  it('renders with only author', () => {
    const wrapper = shallow(
      <Resource title={TITLE} link={URL} external author={AUTHOR} />,
    );
    expect(wrapper.find('.author').exists()).toEqual(true);
    expect(wrapper.find('.tags').exists()).toEqual(false);
  });

  it('renders with tags and author', () => {
    let wrapper = shallow(
      <Resource title={TITLE} link={URL} external tagged />,
    );
    expect(wrapper.find('.author').exists()).toEqual(true);
    expect(wrapper.find('.author').text()).toEqual('');
    expect(wrapper.find('.tags').exists()).toEqual(true);
    expect(wrapper.find('Tag').length).toEqual(0);

    wrapper = shallow(
      <Resource title={TITLE} link={URL} external author={AUTHOR} tagged />,
    );
    expect(wrapper.find('.author').exists()).toEqual(true);
    expect(wrapper.find('.author').text()).toEqual(AUTHOR);
    expect(wrapper.find('.tags').exists()).toEqual(true);
    expect(wrapper.find('Tag').length).toEqual(0);

    wrapper = shallow(
      <Resource
        title={TITLE}
        link={URL}
        external
        author={AUTHOR}
        tagged
        tags={TAGS}
      />,
    );
    expect(wrapper.find('.author').exists()).toEqual(true);
    expect(wrapper.find('.author').text()).toEqual(AUTHOR);
    expect(wrapper.find('.tags').exists()).toEqual(true);
    expect(wrapper.find('Tag').length).toEqual(TAGS.length);

    wrapper = shallow(
      <Resource
        title={TITLE}
        link={URL}
        external
        author={AUTHOR}
        tagged
        tags={EMPTY_TAGS}
      />,
    );
    expect(wrapper.find('.author').exists()).toEqual(true);
    expect(wrapper.find('.author').text()).toEqual(AUTHOR);
    expect(wrapper.find('.tags').exists()).toEqual(true);
    expect(wrapper.find('Tag').length).toEqual(0);

    wrapper = shallow(
      <Resource title={TITLE} link={URL} external tagged tags={TAGS} />,
    );
    expect(wrapper.find('.author').exists()).toEqual(true);
    expect(wrapper.find('.author').text()).toEqual('');
    expect(wrapper.find('.tags').exists()).toEqual(true);
    expect(wrapper.find('Tag').length).toEqual(TAGS.length);

    wrapper = shallow(
      <Resource title={TITLE} link={URL} external tagged tags={EMPTY_TAGS} />,
    );
    expect(wrapper.find('.author').exists()).toEqual(true);
    expect(wrapper.find('.author').text()).toEqual('');
    expect(wrapper.find('.tags').exists()).toEqual(true);
    expect(wrapper.find('Tag').length).toEqual(0);
  });
});
