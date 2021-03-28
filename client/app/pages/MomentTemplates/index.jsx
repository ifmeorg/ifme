// @flow
import React, { useState } from 'react';
import { I18n } from 'libs/i18n';
import { Story } from 'components/Story';
import { PageTitle } from 'components/PageTitle';
import Modal from 'components/Modal';
import { Utils } from 'utils';
import MomentTemplatesForm from 'pages/MomentTemplates/MomentTemplatesForm';
import type { Template } from 'pages/MomentTemplates/MomentTemplatesForm';
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
          templates && I18n.t('moment_templates.index.instructions')
        }
      />
      {templates && (
        <div className="gridTwo marginTop">
          {templates.map((template) => {
            const { name, id } = template;
            return (
              <div className="gridTwoItemBoxLight" key={id}>
                <Story
                  name={name}
                  actions={{
                    delete: {
                      name: I18n.t('common.actions.delete'),
                      link: `/moment_templates/destroy?id=${id}`,
                      dataConfirm: I18n.t('common.actions.confirm'),
                      dataMethod: 'delete',
                    },
                    edit: {
                      name: I18n.t('common.actions.edit'),
                      onClick: () => editTemplate(template),
                    },
                  }}
                />
              </div>
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
