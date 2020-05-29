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

const BaseContainerComponent = ({
  container: containerProps,
  data: dataProps,
  fetchUrl: fetchUrlProps,
  lastPage: lastPageProps,
}: Props) => {
  const [page, setpage] = useState(1);
  const [lastPage, setlastPage] = useState(!!lastPageProps);
  const [data, setdata] = useState(dataProps);

  const onClick = () => {
    const fetchUrl = fetchUrlProps;
    let url = new URL(`${window.location.origin + fetchUrl}`);
    url = `${url.origin}${url.pathname}.json?page=${page + 1}${
      url.search ? `&${url.search.substring(1)}` : ''
    }`;
    axios.get(url).then((response: any) => {
      if (response.data) {
        setlastPage(response.data.lastPage);
        setpage(page + 1);
        setdata(data.concat(response.data.data));
      }
    });
  };

  const container = containerProps;
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
};

export function BaseContainer({
  container,
  data,
  fetchUrl,
  lastPage,
}: Props) {
  return (
    <BaseContainerComponent
      container={container}
      data={data}
      fetchUrl={fetchUrl}
      lastPage={lastPage}
    />
  );
}
