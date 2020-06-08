// @flow
import React, { useState } from 'react';
import { I18n } from '../../libs/i18n';
import { Utils } from '../../utils';
import ContactsContext from './CarePlanContactsContext';
import DynamicForm from '../../components/Form/DynamicForm';
import css from './CarePlanContacts.scss';

export type Contact = {
  id: number,
  name: string,
  phone?: string,
};

type Response = {
  error?: string,
  data?: Contact,
};

export type Props = {
  contact?: Contact,
};

export const CarePlanContactsForm = ({ contact }: Props) => {
  const [error, setError] = useState();
  const action = `/care_plan_contacts/${
    contact ? `update?id=${contact.id}` : 'create'
  }`;

  const onSubmit = (response: Response, context: Object) => {
    const {
      contacts,
      setContacts,
      setEditableContact,
      setOpenModal,
      setModalKey,
    } = context;
    if (response.error) {
      setError(response.error);
    } else {
      let newContacts = [...contacts];
      if (contact) {
        newContacts = newContacts.filter((c) => c.id !== contact.id);
      }
      newContacts.push(response.data);
      setContacts(newContacts.sort((a, b) => a.name.localeCompare(b.name)));
      setOpenModal(false);
      setModalKey(Utils.randomString());
      setEditableContact(null);
    }
  };

  return (
    <ContactsContext.Consumer>
      {(context) => (
        <>
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
    </ContactsContext.Consumer>
  );
};

// There's a [bug](https://github.com/shakacode/react_on_rails/issues/1198) with React on Rails,
// so we'll need to do this in order to render multiple components with hooks on the same page.
export default ({ contact }: Props) => (
  <CarePlanContactsForm contact={contact} />
);
