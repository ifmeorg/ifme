// @flow
import React from 'react';
import { Utils } from 'utils';
import { Tag } from 'components/Tag';
import css from './Resource.scss';

type Props = {
  author?: string,
  link: string,
  tags?: string[],
  title: string,
  updateTagFilter?: Function,
};

const scrollUp = () => {
  window.scrollTo(0, 0);
};

const taggedResources = (tags: ?(string[]), updateTagFilter) => {
  if (tags) {
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
                  scrollUp();
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

const authorRes = (author: ?string) => {
  if (!author) return null;
  return <div className={`author ${css.author}`}>{author}</div>;
};

export const Resource = (props: Props) => {
  const {
    author, link, tags = [], title, updateTagFilter,
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
      {authorRes(author)}
      {taggedResources(tags, updateTagFilter)}
    </div>
  );
};
