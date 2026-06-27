import { pipeline } from '@huggingface/transformers';

const LABELS = [
  'anxiety',
  'depression',
  'grief',
  'crisis',
  'self-harm',
  'loneliness',
  'anger',
  'trauma',
];

let classifier = null;

self.onmessage = async (event) => {
  const { text } = event.data;
  try {
    if (!classifier) {
      classifier = await pipeline(
        'zero-shot-classification',
        'Xenova/mDeBERTa-v3-base-mnli-xnli',
        { quantized: true },
      );
    }
    const result = await classifier(text, LABELS, { multi_label: true });
    self.postMessage({ result });
  } catch (error) {
    self.postMessage({ error: error.message });
  }
};
