// @flow
import React from 'react';
import css from './Resources.scss';
import Tag from '../Tag';

type Props = {
  resourcesObj?: object,
  tagged?: boolean,
};

export default class Resources extends React.Component<Props> {
  constructor(props: Props) {
    super(props);
  }

  render() {
    const { resourcesObj, tagged } = this.props;
    const resources = tagged === true ? resourcesObj.tags.map((tag, index) =>
      <Tag normal label={tag} key={index} />,
    ) : <div className={css.author}>{resourcesObj.author}</div>;

    return (
      <div className={css.container}>
        <div className={css.dash} />
        <div className={css.link}><a href={resourcesObj.link} target="blank">{resourcesObj.name}</a></div>
        { resources }
      </div>
    );
  }
}

