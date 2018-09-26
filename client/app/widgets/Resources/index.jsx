// @flow
import React from 'react';
import css from './Resources.scss';
import { Resource } from '../../components/Resource';
import { Utils } from '../../utils';

export type Props = {
  resources: any,
};

export const Resources = (props: Props) => {
  const { resources } = props;
  return (
    <div className={css.gridThree}>
      {resources.map(resource => (
        <div className={css.gridThreeItem} key={Utils.randomString()}>
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
};
