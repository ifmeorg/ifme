// @flow
/* eslint react/jsx-props-no-spreading: 0 */
import React, { Suspense, lazy } from 'react';
import type { Node } from 'react';

const ChartRenderer = lazy(() => import('./ChartRenderer'));

type chartShape = {
  xtitle?: string,
  ytitle?: string,
  data?: Object | any[],
  chartType: 'Line' | 'Area',
};

export function Chart(props: chartShape): Node {
  return (
    <Suspense fallback={null}>
      <ChartRenderer {...props} />
    </Suspense>
  );
}
