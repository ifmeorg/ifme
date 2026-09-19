// @flow
/* eslint react/jsx-props-no-spreading: 0 */
import React, { Suspense, lazy } from 'react';
import type { Node } from 'react';
import { Skeleton } from 'components/Skeleton';

const ChartRenderer = lazy(() => import('./ChartRenderer'));

// react-chartkick draws charts 300px tall by default, so the placeholder
// holds the same space while the chart code loads.
const CHART_HEIGHT = '300px';

type chartShape = {
  xtitle?: string,
  ytitle?: string,
  data?: Object | any[],
  chartType: 'Line' | 'Area',
};

export function Chart(props: chartShape): Node {
  return (
    <Suspense fallback={<Skeleton height={CHART_HEIGHT} />}>
      <ChartRenderer {...props} />
    </Suspense>
  );
}
