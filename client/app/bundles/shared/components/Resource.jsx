// @flow
import React from 'react';
import shortid from 'shortid';
import css from './Resource.scss';
import Tag from './Tag';

type Props = {
  tags: [],
  tagged?: boolean,
  external?: boolean,
  link?: string,
  name?: string,
  author?: string,
};

export default class Resource extends React.Component<Props> {
  render() {
    const { tags, link, name, author, tagged, external } = this.props;
    const taggedResources = tagged ? tags.map(tag =>
      <Tag normal label={tag} key={shortid.generate()} />,
    ) : '';
    const authorRes = external ? <div className={css.author}>{author}</div> : '';

    return (
      <div className={css.container}>
        <div className={css.link}><a href={link} target="blank">{name}</a></div>
        { authorRes }
        { taggedResources }
      </div>
    );
  }
}

