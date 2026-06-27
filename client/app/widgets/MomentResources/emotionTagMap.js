// Maps zero-shot emotion labels to resource tag keys from resources.json.
// Tag keys must match the raw (untranslated) keys in resources.json.
export const EMOTION_RESOURCE_MAP = {
  anxiety: ['self_care', 'hotlines', 'chatbot', 'communities'],
  depression: ['depression', 'self_care', 'hotlines', 'communities'],
  grief: ['communities', 'self_care', 'support_groups'],
  crisis: ['hotlines', 'self_injury'],
  'self-harm': ['self_injury', 'hotlines'],
  loneliness: ['communities', 'chatbot', 'support_groups'],
  anger: ['self_care', 'communities'],
  trauma: ['self_care', 'support_groups'],
};
