// @flow
import React from 'react';
import shortid from 'shortid';
import css from './Resource.scss';
import Tag from './Tag';

type Props = {
  tags: [],
  tagged?: boolean,
  link?: string,
  name?: string,
  author?: string,
};

export default class Resource extends React.Component<Props> {
  render() {
    const { tags, link, name, author, tagged } = this.props;
    const resources = tagged ? tags.map(tag =>
      <Tag normal label={tag} key={shortid.generate()} />,
    ) : <div className={css.author}>{author}</div>;

    return (
      <div className={css.container}>
        <div className={css.link}><a href={link} target="blank">{name}</a></div>
        { resources }
      </div>
    );
  }
}

