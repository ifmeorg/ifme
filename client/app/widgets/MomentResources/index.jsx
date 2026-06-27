// @flow
import React, { useState, useEffect, useRef } from 'react';
import type { Node } from 'react';
import { createEmotionWorker } from 'workers/createEmotionWorker';
import { EMOTION_RESOURCE_MAP } from './emotionTagMap';

const MAX_DISPLAYED = 3;
const EMOTION_THRESHOLD = 0.3;

type Resource = {
  name: string,
  link: string,
  tag_keys?: string[],
};

type EmotionResult = {
  labels: string[],
  scores: number[],
};

type Props = {
  resources: Resource[],
  text: string,
  resourcesTagsUrl: string,
  label: string,
  loadMoreText: string,
};

export const rerankByEmotion = (
  resources: Resource[],
  { labels, scores }: EmotionResult,
): Resource[] => {
  const activeEmotions = labels
    .map((label, i) => ({ label, score: scores[i] }))
    .filter(({ score }) => score > EMOTION_THRESHOLD);

  if (activeEmotions.length === 0) return resources;

  const scored = resources.map((resource, index) => {
    const serverScore = resources.length - index;
    let emotionBoost = 0;

    activeEmotions.forEach(({ label, score }) => {
      const mappedKeys = EMOTION_RESOURCE_MAP[label] || [];
      const resourceKeys = resource.tag_keys || [];
      const matches = resourceKeys.filter((key) => mappedKeys.includes(key)).length;
      emotionBoost += matches * score * 2;
    });

    return { resource, totalScore: serverScore + emotionBoost };
  });

  return scored
    .sort((a, b) => b.totalScore - a.totalScore)
    .map(({ resource }) => resource);
};

const MomentResources = ({
  resources: initialResources,
  text,
  resourcesTagsUrl,
  label,
  loadMoreText,
}: Props): Node => {
  const [resources, setResources] = useState(initialResources);
  const workerRef = useRef(null);

  useEffect(() => {
    if (!text || !initialResources.length || typeof Worker === 'undefined') return;

    workerRef.current = createEmotionWorker();

    workerRef.current.onmessage = (event) => {
      if (event.data.error || !event.data.result) return;
      setResources(rerankByEmotion(initialResources, event.data.result));
    };

    workerRef.current.postMessage({ text });

    return () => {
      workerRef.current?.terminate();
    };
  }, [text]);

  const displayed = resources.slice(0, MAX_DISPLAYED);

  return (
    <div className="smallMarginTop">
      <div className="label">
        <label>{label}</label>
      </div>
      <ul>
        {displayed.map((item) => (
          <li key={item.name}>
            <a href={item.link} rel="noopener noreferrer" target="_blank">
              {item.name}
            </a>
          </li>
        ))}
        <li>
          <a href={resourcesTagsUrl}>{loadMoreText}</a>
        </li>
      </ul>
    </div>
  );
};

export default MomentResources;
