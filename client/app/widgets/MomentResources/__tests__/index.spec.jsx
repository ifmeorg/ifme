import React from 'react';
import { render, screen, act } from '@testing-library/react';
import MomentResources, { rerankByEmotion } from 'widgets/MomentResources';

let mockWorker;

jest.mock('workers/createEmotionWorker', () => ({
  createEmotionWorker: jest.fn(() => mockWorker),
}));

const RESOURCES = [
  { name: 'Calm App', link: 'https://calm.com', tag_keys: ['self_care', 'ios'] },
  { name: 'Crisis Line', link: 'https://crisis.org', tag_keys: ['hotlines', 'communities'] },
  { name: 'Depression Forum', link: 'https://dep.org', tag_keys: ['depression', 'communities'] },
  { name: 'Yoga Videos', link: 'https://yoga.com', tag_keys: ['self_care', 'videos'] },
];

const DEFAULT_PROPS = {
  resources: RESOURCES,
  text: 'I feel overwhelmed and anxious',
  resourcesTagsUrl: '/resources?filter[]=self_care',
  label: 'Resources',
  loadMoreText: 'Load more...',
};

beforeEach(() => {
  mockWorker = {
    postMessage: jest.fn(),
    terminate: jest.fn(),
    onmessage: null,
  };
  // jsdom doesn't define Worker; define it so the component's guard passes
  global.Worker = jest.fn();
});

afterEach(() => {
  delete global.Worker;
  jest.clearAllMocks();
});

describe('MomentResources', () => {
  describe('initial render', () => {
    it('renders the section label', () => {
      render(<MomentResources {...DEFAULT_PROPS} />);
      expect(screen.getByText('Resources')).toBeInTheDocument();
    });

    it('shows up to 3 resources from the initial server-ranked list', () => {
      render(<MomentResources {...DEFAULT_PROPS} />);
      expect(screen.getByText('Calm App')).toBeInTheDocument();
      expect(screen.getByText('Crisis Line')).toBeInTheDocument();
      expect(screen.getByText('Depression Forum')).toBeInTheDocument();
      expect(screen.queryByText('Yoga Videos')).not.toBeInTheDocument();
    });

    it('renders the load more link', () => {
      render(<MomentResources {...DEFAULT_PROPS} />);
      const link = screen.getByText('Load more...');
      expect(link).toBeInTheDocument();
      expect(link).toHaveAttribute('href', '/resources?filter[]=self_care');
    });

    it('sends the moment text to the worker on mount', () => {
      const { createEmotionWorker } = require('workers/createEmotionWorker');
      render(<MomentResources {...DEFAULT_PROPS} />);
      expect(createEmotionWorker).toHaveBeenCalled();
      expect(mockWorker.postMessage).toHaveBeenCalledWith({
        text: 'I feel overwhelmed and anxious',
      });
    });
  });

  describe('after emotion analysis', () => {
    it('re-ranks resources when the worker returns scores', async () => {
      render(<MomentResources {...DEFAULT_PROPS} />);

      await act(async () => {
        mockWorker.onmessage({
          data: {
            result: {
              labels: ['anxiety', 'depression', 'grief', 'crisis', 'self-harm', 'loneliness', 'anger', 'trauma'],
              scores: [0.85, 0.12, 0.05, 0.05, 0.02, 0.03, 0.02, 0.01],
            },
          },
        });
      });

      // anxiety maps to self_care and hotlines — so Calm App (self_care) and Crisis Line (hotlines)
      // should score higher than Depression Forum (depression tag, no anxiety match)
      const items = screen.getAllByRole('listitem');
      const names = items.map((li) => li.textContent);
      const calmIndex = names.findIndex((n) => n.includes('Calm App'));
      const crisisIndex = names.findIndex((n) => n.includes('Crisis Line'));
      const depIndex = names.findIndex((n) => n.includes('Depression Forum'));

      expect(calmIndex).toBeLessThan(depIndex);
      expect(crisisIndex).toBeLessThan(depIndex);
    });

    it('keeps the server order when no emotions exceed the threshold', async () => {
      render(<MomentResources {...DEFAULT_PROPS} />);

      await act(async () => {
        mockWorker.onmessage({
          data: {
            result: {
              labels: ['anxiety', 'depression'],
              scores: [0.1, 0.05],
            },
          },
        });
      });

      expect(screen.getByText('Calm App')).toBeInTheDocument();
      expect(screen.getByText('Crisis Line')).toBeInTheDocument();
    });

    it('ignores worker errors and keeps the initial ranking', async () => {
      render(<MomentResources {...DEFAULT_PROPS} />);

      await act(async () => {
        mockWorker.onmessage({ data: { error: 'model failed to load' } });
      });

      expect(screen.getByText('Calm App')).toBeInTheDocument();
      expect(screen.getByText('Crisis Line')).toBeInTheDocument();
    });
  });

  describe('when text is empty', () => {
    it('renders initial resources without starting a worker', () => {
      const { createEmotionWorker } = require('workers/createEmotionWorker');
      render(<MomentResources {...DEFAULT_PROPS} text="" />);
      expect(createEmotionWorker).not.toHaveBeenCalled();
      expect(screen.getByText('Calm App')).toBeInTheDocument();
    });
  });
});

describe('rerankByEmotion', () => {
  it('boosts a lower-ranked resource above a higher-ranked one when emotion matches', () => {
    const resources = [
      { name: 'General Blog', link: '/a', tag_keys: ['blog', 'communities'] },
      { name: 'Depression Forum', link: '/b', tag_keys: ['depression', 'self_care'] },
    ];
    // General Blog has server rank 2 (index 0), Depression Forum has rank 1 (index 1)
    // depression emotion maps to 'depression' and 'self_care' — Depression Forum matches both
    const result = rerankByEmotion(resources, {
      labels: ['depression'],
      scores: [0.9],
    });
    expect(result[0].name).toBe('Depression Forum');
  });

  it('returns resources unchanged when all scores are below threshold', () => {
    const result = rerankByEmotion(RESOURCES, {
      labels: ['depression'],
      scores: [0.1],
    });
    expect(result).toEqual(RESOURCES);
  });

  it('combines server rank and emotion boost for final order', () => {
    const resources = [
      { name: 'A', link: '/a', tag_keys: ['hotlines'] },
      { name: 'B', link: '/b', tag_keys: ['self_care'] },
    ];
    // anxiety maps to both hotlines and self_care
    const result = rerankByEmotion(resources, {
      labels: ['anxiety'],
      scores: [0.8],
    });
    // Both get equal emotion boost; A should stay first due to server rank
    expect(result[0].name).toBe('A');
  });
});
