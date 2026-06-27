// @flow
import { useEffect, useRef, useCallback } from 'react';

const AUTOSAVE_PREFIX = 'ifme_autosave_';
const SAVE_INTERVAL_MS = 2000;

export type AutoSavedData = {
  timestamp: number,
  values: { [string]: string },
};

type UseAutoSaveReturn = {
  getSavedData: () => AutoSavedData | null,
  saveData: (values: { [string]: string }) => void,
  clearSavedData: () => void,
  registerSaveCallback: (fn: Function) => void,
};

export const useAutoSave = (storageKey: string): UseAutoSaveReturn => {
  const fullKey = `${AUTOSAVE_PREFIX}${storageKey}`;
  // Holds the latest collect-and-save function so the interval always reads
  // fresh DOM values without needing to be restarted on every render.
  const saveCallbackRef = useRef<Function | null>(null);

  const getSavedData = useCallback((): AutoSavedData | null => {
    try {
      const raw = localStorage.getItem(fullKey);
      return raw ? JSON.parse(raw) : null;
    } catch {
      return null;
    }
  }, [fullKey]);

  const saveData = useCallback((values: { [string]: string }) => {
    if (Object.keys(values).length === 0) return;
    try {
      localStorage.setItem(
        fullKey,
        JSON.stringify({ timestamp: Date.now(), values }),
      );
    } catch {
      // Ignore storage quota errors silently
    }
  }, [fullKey]);

  const clearSavedData = useCallback(() => {
    try {
      localStorage.removeItem(fullKey);
    } catch {
      // Ignore errors silently
    }
  }, [fullKey]);

  const registerSaveCallback = useCallback((fn: Function) => {
    saveCallbackRef.current = fn;
  }, []);

  useEffect(() => {
    const interval = setInterval(() => {
      if (saveCallbackRef.current) {
        saveCallbackRef.current();
      }
    }, SAVE_INTERVAL_MS);
    return () => clearInterval(interval);
    // fullKey changes only when the form action changes (e.g. navigating between
    // new and edit), in which case we want a fresh interval.
  }, [fullKey]);

  return {
    getSavedData,
    saveData,
    clearSavedData,
    registerSaveCallback,
  };
};
