// @flow
import React from 'react';
import { Utils } from '../../utils';
import css from './Resource.scss';
import { Tag } from '../Tag';

type Props = {
  author?: string,
  external?: boolean,
  link: string,
  tags?: string[],
  tagged?: boolean,
  title: string,
  updateTagFilter?: Function,
};

const taggedResources = (
  tagged: ?boolean,
  tags: ?(string[]),
  updateTagFilter,
) => {
  if (tagged && tags) {
    return (
      <div className="tags">
        {tags.map((tag) => (
          <Tag
            normal
            label={tag}
            key={Utils.randomString()}
            onClick={
              updateTagFilter
                ? (tagLabel) => {
                  updateTagFilter(tagLabel);
                }
                : null
            }
          />
        ))}
      </div>
    );
  }
  return null;
};

const authorRes = (external: ?boolean, author: ?string) => {
  if (!external) return null;
  return <div className={`author ${css.author}`}>{author}</div>;
};

export const Resource = (props: Props) => {
  const {
    author,
    external,
    link,
    tagged,
    tags = [],
    title,
    updateTagFilter,
  } = props;
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
      {authorRes(external, author)}
      {taggedResources(tagged, tags, updateTagFilter)}
    </div>
  );
};
