export const createEmotionWorker = () => new Worker(
  new URL('./emotionWorker.js', import.meta.url),
);
