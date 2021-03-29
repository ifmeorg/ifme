// @flow
import React, { useState } from 'react';
import axios from 'axios';
import { I18n } from 'libs/i18n';
import { PageTitle } from 'components/PageTitle';
import Modal from 'components/Modal';
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

  const addPremadeTemplates = () => {
    const premadeOne = axios
      .post('/moment_templates/create', {
        moment_template: {
          name: I18n.t('moment_templates.index.premade1_name'),
          description: I18n.t('moment_templates.index.premade1_description'),
        },
      })
      .then((response: Object) => response);

    const premadeTwo = axios
      .post('/moment_templates/create', {
        moment_template: {
          name: I18n.t('moment_templates.index.premade2_name'),
          description: I18n.t('moment_templates.index.premade2_description'),
        },
      })
      .then((response: Object) => response);

    Promise.all([premadeOne, premadeTwo]).then((values) => {
      const newTemplates = [];
      values.forEach((value) => {
        newTemplates.push(value.data);
      });
      setTemplates(newTemplates.sort((a, b) => a.name.localeCompare(b.name)));
    });
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
          templates.length === 0
          && I18n.t('moment_templates.index.instructions')
        }
      />
      {templates.length === 0 && (
        <div className={css.smallMarginTop}>
          <button
            type="button"
            className={css.buttonDarkS}
            onClick={addPremadeTemplates}
          >
            {I18n.t('common.actions.add_all')}
          </button>
        </div>
      )}
      {templates.length > 0 && (
        <div className="gridTwo marginTop">
          {templates.map((template) => {
            const { id } = template;
            return (
              <MomentTemplate
                key={id}
                template={template}
                editTemplate={editTemplate}
              />
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
