// @flow
import React from 'react';
import css from './Resource.scss';
import Tag from '../Tag';

type Props = {
  resourceObj?: Object,
  tagged?: boolean,
};

export default class Resource extends React.Component<Props> {
  constructor(props: Props) {
    super(props);
  }

  render() {
    const { resourceObj, tagged } = this.props;
    const resources = tagged ? resourceObj.tags.map((tag, index) =>
      <Tag normal label={tag} key={index} />,
    ) : <div className={css.author}>{resourceObj.author}</div>;

    return (
      <div className={css.container}>
        <div className={css.dash} />
        <div className={css.link}><a href={resourceObj.link} target="blank">{resourceObj.name}</a></div>
        { resources }
      </div>
    );
  }
}

