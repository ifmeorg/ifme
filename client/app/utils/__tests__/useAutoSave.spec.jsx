// @flow
import React from 'react';
import { render, act } from '@testing-library/react';
import { useAutoSave } from 'utils/useAutoSave';

const MOMENTS_KEY = 'ifme_autosave_moments';
const CATEGORIES_KEY = 'ifme_autosave_categories';

const HookWrapper = ({ hookRef, formAction }: { hookRef: Object, formAction: string }) => {
  // eslint-disable-next-line no-param-reassign
  hookRef.current = useAutoSave(formAction);
  return null;
};

const renderHook = (formAction = '/moments') => {
  const hookRef = { current: null };
  render(<HookWrapper hookRef={hookRef} formAction={formAction} />);
  return hookRef;
};

describe('useAutoSave', () => {
  beforeEach(() => {
    localStorage.clear();
    jest.useFakeTimers();
  });

  afterEach(() => {
    jest.useRealTimers();
    localStorage.clear();
  });

  describe('per-feature-area storage keys', () => {
    it('uses a key scoped to the form type, not the full URL', () => {
      const hookRef = renderHook('/moments');
      act(() => { hookRef.current.saveData({ moment_name: 'Hello' }); });
      expect(localStorage.getItem(MOMENTS_KEY)).not.toBeNull();
    });

    it('treats /moments and /moments/123 as the same draft slot', () => {
      const hookRef = renderHook('/moments');
      act(() => { hookRef.current.saveData({ moment_name: 'First' }); });

      const hookRef2 = renderHook('/moments/123');
      act(() => { hookRef2.current.saveData({ moment_name: 'Second' }); });

      const stored = JSON.parse(localStorage.getItem(MOMENTS_KEY) || '{}');
      expect(stored.values.moment_name).toBe('Second');
    });

    it('keeps moments and categories drafts independent', () => {
      const momentsHook = renderHook('/moments');
      act(() => { momentsHook.current.saveData({ moment_name: 'My moment' }); });

      const categoriesHook = renderHook('/categories');
      act(() => { categoriesHook.current.saveData({ category_name: 'My category' }); });

      expect(JSON.parse(localStorage.getItem(MOMENTS_KEY) || '{}').values.moment_name).toBe('My moment');
      expect(JSON.parse(localStorage.getItem(CATEGORIES_KEY) || '{}').values.category_name).toBe('My category');
    });
  });

  describe('getSavedData', () => {
    it('returns null when nothing is saved', () => {
      const hookRef = renderHook();
      expect(hookRef.current.getSavedData()).toBeNull();
    });

    it('returns parsed data when a draft exists', () => {
      const draft = { timestamp: Date.now(), values: { moment_name: 'Test' } };
      localStorage.setItem(MOMENTS_KEY, JSON.stringify(draft));
      expect(renderHook('/moments').current.getSavedData()).toEqual(draft);
    });

    it('returns null when stored data is invalid JSON', () => {
      localStorage.setItem(MOMENTS_KEY, 'not-json');
      expect(renderHook('/moments').current.getSavedData()).toBeNull();
    });
  });

  describe('saveData', () => {
    it('writes values to localStorage', () => {
      const hookRef = renderHook('/moments');
      act(() => { hookRef.current.saveData({ moment_name: 'Hello' }); });
      const stored = JSON.parse(localStorage.getItem(MOMENTS_KEY) || '{}');
      expect(stored.values).toEqual({ moment_name: 'Hello' });
      expect(stored.timestamp).toBeDefined();
    });

    it('does not write when values object is empty', () => {
      const hookRef = renderHook();
      act(() => { hookRef.current.saveData({}); });
      expect(localStorage.getItem(MOMENTS_KEY)).toBeNull();
    });

    it('overwrites a previous draft of the same form type', () => {
      const hookRef = renderHook('/moments');
      act(() => { hookRef.current.saveData({ moment_name: 'Old' }); });
      act(() => { hookRef.current.saveData({ moment_name: 'New' }); });
      const stored = JSON.parse(localStorage.getItem(MOMENTS_KEY) || '{}');
      expect(stored.values.moment_name).toBe('New');
    });
  });

  describe('clearSavedData', () => {
    it('removes the draft from localStorage', () => {
      localStorage.setItem(
        MOMENTS_KEY,
        JSON.stringify({ timestamp: Date.now(), values: { moment_name: 'X' } }),
      );
      const hookRef = renderHook('/moments');
      act(() => { hookRef.current.clearSavedData(); });
      expect(localStorage.getItem(MOMENTS_KEY)).toBeNull();
    });

    it('does not affect drafts from other form types', () => {
      localStorage.setItem(
        MOMENTS_KEY,
        JSON.stringify({ timestamp: Date.now(), values: { moment_name: 'Keep' } }),
      );
      localStorage.setItem(
        CATEGORIES_KEY,
        JSON.stringify({ timestamp: Date.now(), values: { category_name: 'Also keep' } }),
      );
      const hookRef = renderHook('/categories');
      act(() => { hookRef.current.clearSavedData(); });
      expect(localStorage.getItem(MOMENTS_KEY)).not.toBeNull();
      expect(localStorage.getItem(CATEGORIES_KEY)).toBeNull();
    });
  });

  describe('registerSaveCallback + interval', () => {
    it('calls the registered save callback every 2 seconds', () => {
      const hookRef = renderHook();
      const mockSave = jest.fn();
      act(() => { hookRef.current.registerSaveCallback(mockSave); });

      expect(mockSave).not.toHaveBeenCalled();
      act(() => { jest.advanceTimersByTime(2000); });
      expect(mockSave).toHaveBeenCalledTimes(1);
      act(() => { jest.advanceTimersByTime(2000); });
      expect(mockSave).toHaveBeenCalledTimes(2);
    });
  });
});
