// @flow
import React, { useState, useRef } from 'react';
import type { Node } from 'react';
import { fetchWrapper } from 'utils/fetchWrapper';
import { I18n } from 'libs/i18n';
import { Utils } from 'utils';

type DownloadStatus = 'idle' | 'enqueued' | 'ready' | 'failed';

const POLL_INTERVAL_MS = 3000;
const STATUS = {
  enqueued: 1,
  success: 2,
  failed: 3,
};

export const DataDownload = (): Node => {
  const [status, setStatus] = useState<DownloadStatus>('idle');
  const [requestId, setRequestId] = useState<?string>(null);
  const [error, setError] = useState<?string>(null);
  const pollRef = useRef<?IntervalID>(null);

  const stopPolling = () => {
    if (pollRef.current) {
      clearInterval(pollRef.current);
      pollRef.current = null;
    }
  };

  const startPolling = (reqId: string) => {
    pollRef.current = setInterval(async () => {
      try {
        const response = await fetchWrapper.get(
          `/users/data/status?request_id=${reqId}`,
        );
        const currentStatus = response?.data?.current_status;
        if (currentStatus === STATUS.success) {
          stopPolling();
          setStatus('ready');
        } else if (currentStatus === STATUS.failed) {
          stopPolling();
          setError(I18n.t('users.data_download.error'));
          setStatus('failed');
        }
      } catch {
        stopPolling();
        setError(I18n.t('users.data_download.error'));
        setStatus('failed');
      }
    }, POLL_INTERVAL_MS);
  };

  const handleRequest = async () => {
    setStatus('enqueued');
    setError(null);
    Utils.setCsrfToken();
    try {
      const response = await fetchWrapper.post('/users/data');
      const reqId = response?.data?.request_id;
      if (!reqId) throw new Error('No request_id returned');
      setRequestId(reqId);
      startPolling(reqId);
    } catch {
      setError(I18n.t('users.data_download.error'));
      setStatus('failed');
    }
  };

  const handleReset = () => {
    stopPolling();
    setStatus('idle');
    setRequestId(null);
    setError(null);
  };

  if (status === 'idle' || status === 'failed') {
    return (
      <div className="smallMarginTop">
        {error && (
          <div role="alert" className="smallMarginBottom">
            {error}
          </div>
        )}
        <button type="button" className="buttonDarkS" onClick={handleRequest}>
          {I18n.t('users.data_download.request')}
        </button>
      </div>
    );
  }

  if (status === 'enqueued') {
    return (
      <div className="smallMarginTop" aria-live="polite">
        {I18n.t('users.data_download.processing')}
      </div>
    );
  }

  if (status === 'ready' && requestId) {
    return (
      <div className="smallMarginTop">
        <a
          href={`/users/data/download?request_id=${requestId}`}
          className="buttonDarkS"
        >
          {I18n.t('users.data_download.download')}
        </a>
        <button
          type="button"
          className="buttonDarkS smallMarginLeft"
          onClick={handleReset}
        >
          {I18n.t('users.data_download.request_new')}
        </button>
      </div>
    );
  }

  return null;
};

export default (): Node => <DataDownload />;
