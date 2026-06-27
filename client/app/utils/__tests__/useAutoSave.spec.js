// @flow
import { renderHook, act } from '@testing-library/react';
import { useAutoSave } from 'utils/useAutoSave';

const STORAGE_KEY = 'ifme_autosave_/moments';

describe('useAutoSave', () => {
  beforeEach(() => {
    localStorage.clear();
    jest.useFakeTimers();
  });

  afterEach(() => {
    jest.useRealTimers();
    localStorage.clear();
  });

  describe('getSavedData', () => {
    it('returns null when nothing is saved', () => {
      const { result } = renderHook(() => useAutoSave('/moments'));
      expect(result.current.getSavedData()).toBeNull();
    });

    it('returns parsed data when a draft exists', () => {
      const draft = { timestamp: Date.now(), values: { moment_name: 'Test' } };
      localStorage.setItem(STORAGE_KEY, JSON.stringify(draft));

      const { result } = renderHook(() => useAutoSave('/moments'));
      expect(result.current.getSavedData()).toEqual(draft);
    });

    it('returns null when stored data is invalid JSON', () => {
      localStorage.setItem(STORAGE_KEY, 'not-json');
      const { result } = renderHook(() => useAutoSave('/moments'));
      expect(result.current.getSavedData()).toBeNull();
    });
  });

  describe('saveData', () => {
    it('writes values to localStorage', () => {
      const { result } = renderHook(() => useAutoSave('/moments'));
      act(() => {
        result.current.saveData({ moment_name: 'Hello' });
      });
      const stored = JSON.parse(localStorage.getItem(STORAGE_KEY) || '{}');
      expect(stored.values).toEqual({ moment_name: 'Hello' });
      expect(stored.timestamp).toBeDefined();
    });

    it('does not write when values object is empty', () => {
      const { result } = renderHook(() => useAutoSave('/moments'));
      act(() => {
        result.current.saveData({});
      });
      expect(localStorage.getItem(STORAGE_KEY)).toBeNull();
    });
  });

  describe('clearSavedData', () => {
    it('removes the draft from localStorage', () => {
      localStorage.setItem(
        STORAGE_KEY,
        JSON.stringify({ timestamp: Date.now(), values: { moment_name: 'X' } }),
      );
      const { result } = renderHook(() => useAutoSave('/moments'));
      act(() => {
        result.current.clearSavedData();
      });
      expect(localStorage.getItem(STORAGE_KEY)).toBeNull();
    });
  });

  describe('registerSaveCallback + interval', () => {
    it('calls the registered save callback every 2 seconds', () => {
      const { result } = renderHook(() => useAutoSave('/moments'));
      const mockSave = jest.fn();
      act(() => {
        result.current.registerSaveCallback(mockSave);
      });

      expect(mockSave).not.toHaveBeenCalled();
      act(() => { jest.advanceTimersByTime(2000); });
      expect(mockSave).toHaveBeenCalledTimes(1);
      act(() => { jest.advanceTimersByTime(2000); });
      expect(mockSave).toHaveBeenCalledTimes(2);
    });
  });
});
