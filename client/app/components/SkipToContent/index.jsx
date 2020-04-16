// @flow
import React from 'react';
import css from './SkipToContent.scss';

function SkipToContent(props) {
  return <a className={css.test} href={"#", props.id}>Skip to main content</a>;
}

export default SkipToContent;

// export const SkipToContent = () => {
//   return (
//     <a className={css.test} href="#mainContent">Skip to main content</a>
//   );
// };
