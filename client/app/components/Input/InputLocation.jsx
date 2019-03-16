// @flow
import React from 'react';
import LocationAutocomplete from 'location-autocomplete';
import { I18n } from '../../libs/i18n';

export type Props = {
  placeholder: string,
  apiKey: string,
  id: string,
  value?: any,
};

export type State = {
  address: string,
};

export class InputLocation extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { address: props.value || '' };
  }

  handleChange = (event: SyntheticInputEvent<HTMLInputElement>) => {
    const address: string = event.target.value;
    this.setState({ address });
  };

  handleDropdownSelect = (event: any) => {
    const address: string = event.input.value;
    this.setState({ address });
  };

  render() {
    const ariaLabel = I18n.t('common.form.location');
    const { placeholder } = this.props;
    const { apiKey } = this.props;
    const { id } = this.props;
    const { address } = this.state;
    return (
      <LocationAutocomplete
        name="user[location]"
        placeholder={placeholder}
        googleAPIKey={apiKey}
        onChange={this.handleChange}
        onDropdownSelect={this.handleDropdownSelect}
        className="smallerMarginBottom"
        id={id}
        aria-label={ariaLabel}
        value={address}
      />
    );
  }
}
