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

export function BaseContainer(props: Props){

  const BaseContainerComponent = (props) => {
    const [page, setpage] = useState(1);
    const [lastPage, setlastPage] = useState(!!props.lastPage)
    const [data, setdata] = useState(props.data)

    const onClick = () => {
      const { fetchUrl } = props;
      let url = new URL(`${window.location.origin + fetchUrl}`);
      url = `${url.origin}${url.pathname}.json?page=${page + 1}${
        url.search ? `&${url.search.substring(1)}` : ''
      }`;
      axios.get(url).then((response: any) => {
        if (response.data) {
          setlastPage(response.data.lastPage);
          setpage(page+1);
          setdata(data.concat(response.data.data));
        }
      });
    };

    const { container } = props;
    switch (container) {
      case 'StoryContainer':
      default:
        return (
          <>
            <StoryContainer data={data} />
            {!lastPage && <LoadMoreButton onClick={onClick} />}
          </>
        );
    }
  }
  return <BaseContainerComponent {...props}/>;
}
