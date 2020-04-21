// @flow
import React from 'react';
import css from './SkipToContent.scss';
import { I18n } from '../../libs/i18n';

export type Props = {
  id?: string,
};

function SkipToContent(props: Props) {
  return <a className={css.skipToContent} href={`#${props.id}`}>Skip to main content</a>;
}

// try and error to insert i18n library
  
// function SkipToContent(props: Props) {

//   const translations = async () => (
//     <div
//       aria-label={I18n.t('navigation.skip_to_main_content')}
//     ></div>);

  // I18n.t('navigation.skip_to_main_content'); 

  // return <a className={css.skipToContent} href={`#${props.id}` aria-label="t(navigation.skip_to_main_content)" >Skip to main content</a>;
  // return <a className={css.skipToContent} href={`#${props.id}` aria-label={t(navigation.skip_to_main_content)} >Skip to main content</a>;
  // return <a className={css.skipToContent} href={`#${props.id}`}>Skip to main content</a>, translations();
  // return I18n.t('navigation.skip_to_main_content'); 
  

export default SkipToContent;

