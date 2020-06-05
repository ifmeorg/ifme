// @flow
import React from 'react';
import { I18n } from '../../libs/i18n';
import DynamicForm from '../../components/Form/DynamicForm';

type Contact = {
  id: number,
  name: string,
  phone?: string,
};

export type Props = {
  contact?: Contact,
};

export const CarePlanContactsForm = ({ contact }: Props) => {
  const action = `/care_plan_contacts/${
    contact ? `update?id=${contact.id}` : 'create'
  }`;

  const onSubmit = () => {
    window.location.reload();
    // TODO: handle errors using e: SyntheticEvent<HTMLInputElement>
  };

  return (
    <DynamicForm
      type={contact ? 'patch' : 'post'}
      formProps={{
        action,
        inputs: [
          {
            id: 'care_plan_contact_name',
            name: 'care_plan_contact[name]',
            type: 'text',
            label: I18n.t('common.name'),
            dark: true,
            required: true,
            value: contact && contact.name,
          },
          {
            id: 'care_plan_contact_phone',
            name: 'care_plan_contact[phone]',
            type: 'tel',
            label: I18n.t('care_plan.index.phone_number'),
            dark: true,
            value: contact && contact.phone,
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
      onSubmit={onSubmit}
    />
  );
};

// There's a [bug](https://github.com/shakacode/react_on_rails/issues/1198) with React on Rails,
// so we'll need to do this in order to render multiple components with hooks on the same page.
export default ({ contact }: Props) => (
  <CarePlanContactsForm contact={contact} />
);
