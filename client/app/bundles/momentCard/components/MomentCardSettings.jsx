// @flow
import React from 'react';
import MomentCardViewers from './MomentCardViewers';

type MomentCardSettingsState = {};

type MomentCardSettingsProp = {};

export default class MomentCardSettings extends
  React.Component<MomentCardSettingsProp, MomentCardSettingsState> {
  props: MomentCardSettingsProp;
  state: MomentCardSettingsState;

  render() {
    return (
      <div className="moment_settings">
        <div><i className="fa fa-pencil action" /></div>
        <div><i className="fa fa-trash-o action" /></div>
        <MomentCardViewers />
      </div>
    );
  }
}
