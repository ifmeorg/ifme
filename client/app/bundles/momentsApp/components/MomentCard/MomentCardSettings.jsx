// @flow
import React from 'react';
import css from './MomentCard.scss';

type MomentCardSettingsProp = {
  action: {
    edit?: any,
    delete?: any,
    viewer?: any
  },
};

const classMap = {
  edit: 'fa-pencil',
  delete: 'fa-trash-o',
  viewer: 'fa-lock',
};

export default class MomentCardSettings extends React.Component<MomentCardSettingsProp> {
  render() {
    const { action } = this.props;
    return (
      <div className={css.settings}>
        {
          ['edit', 'delete', 'viewer'].map(op => action[op] &&
            <i role="presentation" onClick={action[op]} className={`fa ${classMap[op]} ${css.action}`} />,
          )
        }
      </div>
    );
  }
}
