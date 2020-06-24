// @flow
import React, { useState } from 'react';
import { I18n } from '../../libs/i18n';
import { Story } from '../../components/Story';
import Modal from '../../components/Modal';
import { Utils } from '../../utils';
import CarePlanContactsForm from './CarePlanContactsForm';
import type { Contact } from './CarePlanContactsForm';
import ContactsContext from './CarePlanContactsContext';
import css from './CarePlanContacts.scss';

type Props = {
  contacts: Contact[],
};

export const CarePlanContacts = ({ contacts: contactsProp }: Props) => {
  const [editableContact, setEditableContact] = useState();
  const [modalKey, setModalKey] = useState();
  const [contacts, setContacts] = useState(contactsProp || []);
  const [openModal, setOpenModal] = useState(false);

  const editContact = (contact) => {
    setEditableContact(contact);
    setOpenModal(true);
    setModalKey(Utils.randomString());
  };

  return (
    <ContactsContext.Provider
      value={{
        contacts,
        setContacts,
        setEditableContact,
        setOpenModal,
        setModalKey,
      }}
    >
      <div className="pageSubtitle">
        <h2>{I18n.t('care_plan.index.contacts')}</h2>
        <div className="pageSubtitleRight">
          <Modal
            className={css.newContact}
            element={(
              <button type="button" className={css.buttonS}>
                {I18n.t('care_plan.index.new_contact')}
              </button>
            )}
            title={I18n.t(
              `care_plan.index.${editableContact ? 'edit' : 'new'}_contact`,
            )}
            body={<CarePlanContactsForm contact={editableContact} />}
            open={openModal}
            modalKey={modalKey}
          />
        </div>
      </div>
      {I18n.t('care_plan.index.contacts_info')}
      <div className="gridTwo marginTop">
        {contacts
          && contacts.map((contact) => {
            const { name, phone, id } = contact;
            return (
              <div className="gridTwoItemBoxLight" key={id}>
                <Story
                  name={name}
                  body={phone}
                  actions={{
                    delete: {
                      name: I18n.t('common.actions.delete'),
                      link: `/care_plan_contacts/destroy?id=${id}`,
                      dataConfirm: I18n.t('common.actions.confirm'),
                      dataMethod: 'delete',
                    },
                    edit: {
                      name: I18n.t('common.actions.edit'),
                      onClick: () => editContact(contact),
                    },
                  }}
                />
              </div>
            );
          })}
      </div>
    </ContactsContext.Provider>
  );
};

// There's a [bug](https://github.com/shakacode/react_on_rails/issues/1198) with React on Rails,
// so we'll need to do this in order to render multiple components with hooks on the same page.
export default ({ contacts }: Props) => (
  <CarePlanContacts contacts={contacts} />
);
