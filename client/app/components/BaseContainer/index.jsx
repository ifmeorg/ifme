// @flow
import React from 'react';
import axios from 'axios';
import { StoryContainer } from './StoryContainer';

export type Props = {
  container: string,
  data: any,
  fetchUrl: string,
  isLastPage?: boolean,
};

export type State = {
  loading: boolean,
  isLastPage: boolean,
  page: number,
  data: any,
};

export class BaseContainer extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      page: 1,
      isLastPage: props.isLastPage || false,
      loading: false,
      data: props.data,
    };
  }

  componentDidMount() {
    window.addEventListener('scroll', this.handleScroll);
  }

  componentDidUpdate() {
    const { isLastPage } = this.state;
    if (isLastPage) {
      window.removeEventListener('scroll', this.handleScroll);
    }
  }

  componentWillUnmount() {
    window.removeEventListener('scroll', this.handleScroll);
  }

  calculateDocument = () => {
    if (document.documentElement) {
      return (
        document.documentElement.offsetHeight
        - document.documentElement.scrollTop
      );
    }
    return 0;
  };

  handleScroll = () => {
    const { fetchUrl } = this.props;
    const { page, loading, data } = this.state;
    if (
      !loading
      && document.getElementsByClassName('footer')[0].clientHeight
        + window.innerHeight
        > this.calculateDocument()
    ) {
      const url = `${window.location.origin + fetchUrl}.json?page=${page + 1}`;
      this.setState({ loading: true });
      axios
        .get(url)
        .then((response: any) => {
          this.setState({
            loading: false,
            page: page + 1,
            data: data.concat(response.data.data),
            isLastPage: response.data.lastPage,
          });
        })
        .catch((error) => {
          console.log(`fail fetching data, error: ${error}`);
          this.setState({
            loading: false,
          });
        });
    }
  };

  switchContainers = () => {
    const { data } = this.state;
    const { container } = this.props;
    switch (container) {
      case 'StoryContainer':
      default:
        return <StoryContainer data={data} />;
    }
  };

  render() {
    return this.switchContainers();
  }
}
