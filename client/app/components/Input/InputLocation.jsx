// @flow
import React from 'react';
import css from './Input.scss';
import { I18n } from '../../libs/i18n';

export type Props = {
  placeholder: string,
}

export type State = {
  address: string,
}

export class InputLocation extends React.Component<Props, State> {
  constructor(props) {
    super(props);
    this.state = { address: '' };
  }

  componentDidMount() {
    const input: HTMLInputElement = document.getElementById('user_input');
    const searchBox: HTMLInputElement = new google.maps.places.Autocomplete(input);

    google.maps.event.addListener(searchBox, 'place_changed', () => {
      const address = searchBox.getPlace().formatted_address;
      this.setState({ address })
    });
  }

  handleChange = (event: SyntheticInputEvent<HTMLInputElement>) => {
    const address = event.target.value;
    this.setState({ address })
  }

  render() {
    const ariaLabel = I18n.t('common.form.location');
    return(
      <input
        type='text'
        id='user_input'
        className='smallerMarginBottom'
        placeholder={this.props.placeholder}
        onChange={this.handleChange}
        value={this.state.address}
        aria-label={ariaLabel}
      />
    );
  }
}
