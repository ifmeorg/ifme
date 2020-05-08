// @flow
import React, { useState } from 'react';
import axios from 'axios';
import { StoryContainer } from './StoryContainer';
import { LoadMoreButton } from '../LoadMoreButton';

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

export const BaseContainer = (props: Props) => {
  const { container } = props;
  const [state, setState] = useState<State>({
    page: 1,
    lastPage: !!lastPage,
    data,
  });

  const onClick = () => {
    const { page, data } = state;
    const { fetchUrl } = props;
    let url = new URL(`${window.location.origin + fetchUrl}`);
    url = `${url.origin}${url.pathname}.json?page=${page + 1}${
      url.search ? `&${url.search.substring(1)}` : ''
    }`;
    axios.get(url).then((response: any) => {
      if (response.data) {
        setState({
          lastPage: response.data.lastPage,
          page: page + 1,
          data: data.concat(response.data.data),
        });
      }
    });
  };

  return (
    <>
      <StoryContainer data={state.data} />
      {!lastPage && <LoadMoreButton onClick={onClick} />}
    </>
  );
};
