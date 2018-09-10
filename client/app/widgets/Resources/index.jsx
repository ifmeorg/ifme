// @flow
import React from 'react';
// import { injectIntl, FormattedMessage, IntlProvider } from 'react-intl';
import css from './Resources.scss';
import { Resource } from '../../components/Resource';
// import { defaultMessages, defaultLocale } from '../../libs/i18n/default';

export interface Props {
  resources: any;
}

export interface State {}

export class Resources extends React.Component<Props, State> {
  // constructor(props: Props) {
  //   super(props);
  // }

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
