// @flow
import React from 'react';
import shortid from 'shortid';
import css from './Resource.scss';
import { Tag } from '../Tag';

type Props = {
  author?: string,
  external?: boolean,
  link: string,
  tags?: string[],
  tagged?: boolean,
  title: string,
};

export class Resource extends React.Component<Props> {
  render() {
    const { author, external, link, tagged, tags = [], title } = this.props;
    const taggedResources = tagged ? (
      <div className="tags">
        {tags.map(tag => <Tag normal label={tag} key={shortid.generate()} />)}
      </div>
    ) : null;
    const authorRes = external ? (
      <div className={`author ${css.author}`}>{author}</div>
    ) : null;

    return (
      <div className={`resource ${css.resource}`}>
        <a
          className={css.link}
          href={link}
          rel="noopener noreferrer"
          target="_blank"
        >
          {title}
        </a>
        {authorRes}
        {taggedResources}
      </div>
    );
  }
}
