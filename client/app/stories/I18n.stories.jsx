import { I18n } from '../libs/i18n';

export default {
  title: 'Libraries/I18n',
};

export const Message = () => I18n.t('draft');

export const MessageWithVariable = () => I18n.t('created', { created_at: 'Blah' });

MessageWithVariable.story = {
  name: 'Message with variable',
};
