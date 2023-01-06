// @flow
import React, { useState } from 'react';
import type { Node } from 'react';
import { I18n } from 'libs/i18n';
import { Utils } from 'utils';
import Modal from 'components/Modal';
import { Story } from 'components/Story';
import type { Template } from 'pages/MomentTemplates/MomentTemplatesForm';

type PremadeTemplate = {
  id?: string,
  name: string,
  description: string,
};

type Props = {
  template: Template | PremadeTemplate,
  editTemplate?: Function,
};

export const MomentTemplate = ({ template, editTemplate }: Props): Node => {
  const { id, name, description } = template;
  const [open, setOpen] = useState(false);
  const [modalKey, setModalKey] = useState();

  return (
    <div className="gridTwoItemBoxLight">
      <Modal title={name} body={description} open={open} modalKey={modalKey} />
      <Story
        name={name}
        onClick={() => {
          setOpen(true);
          setModalKey(Utils.randomString());
        }}
        actions={
          editTemplate && id
            ? {
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
            }
            : undefined
        }
      />
    </div>
  );
};

export default ({ template, editTemplate }: Props): Node => (
  <MomentTemplate template={template} editTemplate={editTemplate} />
);
