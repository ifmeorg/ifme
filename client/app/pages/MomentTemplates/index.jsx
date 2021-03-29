// @flow
import React, { useState } from 'react';
import { I18n } from 'libs/i18n';
import { PageTitle } from 'components/PageTitle';
import Modal from 'components/Modal';
import { Accordion } from 'components/Accordion';
import { Utils } from 'utils';
import MomentTemplatesForm from 'pages/MomentTemplates/MomentTemplatesForm';
import type { Template } from 'pages/MomentTemplates/MomentTemplatesForm';
import MomentTemplate from 'pages/MomentTemplates/MomentTemplate';
import TemplatesContext from './MomentTemplatesContext';
import css from './MomentTemplates.scss';

type Props = {
  templates: Template[],
};

export const MomentTemplates = ({ templates: templatesProp }: Props) => {
  const [editableTemplate, setEditableTemplate] = useState();
  const [modalKey, setModalKey] = useState();
  const [templates, setTemplates] = useState(templatesProp || []);
  const [openModal, setOpenModal] = useState(false);

  const editTemplate = (template) => {
    setEditableTemplate(template);
    setOpenModal(true);
    setModalKey(Utils.randomString());
  };

  return (
    <TemplatesContext.Provider
      value={{
        templates,
        setTemplates,
        setEditableTemplate,
        setOpenModal,
        setModalKey,
      }}
    >
      <PageTitle
        title={I18n.t('moment_templates.index.title')}
        subtitle={I18n.t('moment_templates.index.subtitle')}
        cta={(
          <Modal
            className={css.newTemplate}
            element={(
              <button type="button" className={css.buttonM}>
                {I18n.t('moment_templates.index.new_template')}
              </button>
            )}
            title={I18n.t(
              `moment_templates.index.${
                editableTemplate ? 'edit' : 'new'
              }_template`,
            )}
            body={<MomentTemplatesForm template={editableTemplate} />}
            open={openModal}
            modalKey={modalKey}
          />
        )}
        instructions={
          templates.length === 0 && I18n.t('moment_templates.index.instructions')
        }
      />
      {templates.length > 0 && (
        <div className="gridTwo marginTop">
          {templates.map(({ name, id, description }) => {
            return (
              <MomentTemplate key={id.toString()} id={id.toString()} name={name} description={description} editTemplate={editTemplate} />
            );
          })}
        </div>
      )}
    </TemplatesContext.Provider>
  );
};

export default ({ templates }: Props) => (
  <MomentTemplates templates={templates} />
);
