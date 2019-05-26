// @flow
import React, { Fragment } from 'react';
import axios from 'axios';
import { StoryContainer } from './StoryContainer';
import css from '../../styles/_global.scss';
import { I18n } from '../../libs/i18n';

export type Props = {
  container: string,
  data: any,
  fetchUrl: string,
  lastPage?: boolean,
};

export type State = {
  lastPage: boolean,
  page: number,
  data: any,
};

export class BaseContainer extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    const { data, lastPage } = props;
    this.state = {
      page: 1,
      lastPage: !!lastPage,
      data,
    };
  }

  onClick = () => {
    const { page, data } = this.state;
    const { fetchUrl } = this.props;
    let url = new URL(`${window.location.origin + fetchUrl}`);
    url = `${url.origin}${url.pathname}.json?page=${page + 1}${
      url.search ? `&${url.search.substring(1)}` : ''
    }`;
    axios.get(url).then((response: any) => {
      if (response.data) {
        this.setState({
          lastPage: response.data.lastPage,
          page: page + 1,
          data: data.concat(response.data.data),
        });
      }
    });
  };

  displayLoadMore = () => (
    <center>
      <button
        type="button"
        className={`loadMore ${css.buttonDarkM}`}
        onClick={this.onClick}
      >
        {I18n.t('load_more')}
      </button>
    </center>
  );

  render() {
    const { data, lastPage } = this.state;
    const { container } = this.props;
    switch (container) {
      case 'StoryContainer':
      default:
        return (
          <Fragment>
            <StoryContainer data={data} />
            {!lastPage && this.displayLoadMore()}
          </Fragment>
        );
    }
  }
}
