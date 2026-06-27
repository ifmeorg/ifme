// @flow
import { useEffect, useRef, useCallback } from 'react';

const AUTOSAVE_PREFIX = 'ifme_autosave_';
const SAVE_INTERVAL_MS = 2000;

// Derive a stable key from the form type (first URL path segment).
// /moments, /moments/123, /moments/123/edit → all share 'moments'
const formTypeKey = (action: string): string => {
  const segment = action.split('/').filter(Boolean)[0];
  return `${AUTOSAVE_PREFIX}${segment || 'form'}`;
};

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

export const useAutoSave = (formAction: string): UseAutoSaveReturn => {
  const storageKey = formTypeKey(formAction);
  // Holds the latest collect-and-save function so the interval always reads
  // fresh DOM values without needing to be restarted on every render.
  const saveCallbackRef = useRef<Function | null>(null);

  const getSavedData = useCallback((): AutoSavedData | null => {
    try {
      const raw = localStorage.getItem(storageKey);
      return raw ? JSON.parse(raw) : null;
    } catch {
      return null;
    }
  }, [storageKey]);

  const saveData = useCallback((values: { [string]: string }) => {
    if (Object.keys(values).length === 0) return;
    try {
      localStorage.setItem(
        storageKey,
        JSON.stringify({ timestamp: Date.now(), values }),
      );
    } catch {
      // Ignore storage quota errors silently
    }
  }, [storageKey]);

  const clearSavedData = useCallback(() => {
    try {
      localStorage.removeItem(storageKey);
    } catch {
      // Ignore errors silently
    }
  }, [storageKey]);

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
  }, [storageKey]);

  return {
    getSavedData,
    saveData,
    clearSavedData,
    registerSaveCallback,
  };
};
