/* eslint-disable no-unused-vars */
import { I18n } from 'libs/i18n';

export default {
  title: 'Libraries/I18n',
};

const TranslationWithNoVariableTemplate = (args) => I18n.t('draft');

export const TranslationWithNoVariable = TranslationWithNoVariableTemplate.bind(
  {},
);

TranslationWithNoVariable.storyName = 'Translation with no variable';

const TranslationWithVariableTemplate = (args) => I18n.t('created', { created_at: 'Blah' });

export const TranslationWithVariable = TranslationWithVariableTemplate.bind({});

TranslationWithVariable.storyName = 'Translation with variable';
