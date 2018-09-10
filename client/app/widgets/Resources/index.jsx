// @flow
import React from 'react';
import css from './Resources.scss';
import { Resource } from '../../components/Resource';

export interface Props {
  resources: any;
}

export interface State {}

export class Resources extends React.Component<Props, State> {
  render() {
    const { resources } = this.props;
    return (
      <div className={css.gridTwo}>
        {resources.map(resource => (
          <div className={css.gridTwoItem}>
            <Resource
              tagged
              tags={resource.languages.concat(resource.tags)}
              title={resource.name}
              link={resource.link}
            />
          </div>
        ))}
      </div>
    );
  }
}
