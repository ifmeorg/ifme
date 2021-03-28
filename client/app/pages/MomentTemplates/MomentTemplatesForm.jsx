// @flow
import React, { useState } from 'react';
import { I18n } from 'libs/i18n';
import { Utils } from 'utils';
import DynamicForm from 'components/Form/DynamicForm';
import TemplatesContext from './MomentTemplatesContext';
import css from './MomentTemplates.scss';

export type Template = {
  id: number,
  name: string,
  description: string,
};

type Response = {
  error?: string,
  data?: Template,
};

export type Props = {
  template?: Template,
};

export const MomentTemplatesForm = ({ template }: Props) => {
  const [error, setError] = useState();
  const action = `/moment_templates/${
    template ? `update?id=${template.id}` : 'create'
  }`;

  const onSubmit = (response: Response, context: Object) => {
    const {
      templates,
      setTemplates,
      setEditableTemplate,
      setOpenModal,
      setModalKey,
    } = context;
    if (response.error) {
      setError(response.error);
    } else {
      let newTemplates = [...templates];
      if (template) {
        newTemplates = newTemplates.filter((c) => c.id !== template.id);
      }
      newTemplates.push(response.data);
      setTemplates(newTemplates.sort((a, b) => a.name.localeCompare(b.name)));
      setOpenModal(false);
      setModalKey(Utils.randomString());
      setEditableTemplate(null);
    }
  };

  return (
    <TemplatesContext.Consumer>
      {(context) => (
        <>
          <DynamicForm
            type={template ? 'patch' : 'post'}
            formProps={{
              action,
              inputs: [
                {
                  id: 'moment_template_name',
                  name: 'moment_template[name]',
                  type: 'text',
                  label: I18n.t('common.name'),
                  dark: true,
                  required: true,
                  value: template && template.name,
                },
                {
                  id: 'moment_template_description',
                  name: 'moment_template[description]',
                  type: 'textarea',
                  label: I18n.t('common.form.description'),
                  dark: true,
                  required: true,
                  value: template && template.description,
                },
                {
                  dark: true,
                  id: 'submit',
                  name: 'commit',
                  type: 'submit',
                  value: I18n.t('common.actions.submit'),
                },
              ],
            }}
            onSubmit={(response) => onSubmit(response, context)}
          />
          {error && (
            <div
              className={`${css.errorField} ${css.smallMarginTop}`}
              role="alert"
            >
              {error}
            </div>
          )}
        </>
      )}
    </TemplatesContext.Consumer>
  );
};

export default ({ template }: Props) => (
  <MomentTemplatesForm template={template} />
);
