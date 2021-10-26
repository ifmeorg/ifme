// @flow
import React, { useEffect } from 'react';
import { Utils } from 'utils';
import { I18n } from 'libs/i18n';
import globalCSS from 'styles/_global.scss';

type Props = {
  title: string,
  subtitle: string,
  cta?: any,
  instructions?: any,
};

export const PageTitle = ({
  title, subtitle, cta, instructions,
}: Props) => {
  useEffect(() => {
    window.document.title = `${I18n.t('app_name')} - ${title}`;
  });

  return (
    <>
      <h1 className={globalCSS.pageTitle}>
        <div>{title}</div>
        {cta && <div className={globalCSS.pageTitleRight}>{cta}</div>}
      </h1>
      <div className={globalCSS.subtitle}>{subtitle}</div>
      {Utils.renderContent(instructions)}
    </>
  );
};
