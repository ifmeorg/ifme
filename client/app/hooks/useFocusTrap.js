// @flow
import { useEffect } from 'react';

export const useFocusTrap = (
  ref: { current: null | HTMLElement },
  isOpen: boolean,
) => {
  const handleKeyDown = (e: any) => {
    const focusableElements = 'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])';
    const element = ref.current;
    if (!element) return;

    const focusableContent = element.querySelectorAll(focusableElements);
    const visibleContent = Array.from(focusableContent).filter(
      (node) => window.getComputedStyle(node).display !== 'none',
    );

    const firstFocusableElement = visibleContent[0];
    const lastFocusableElement = visibleContent[visibleContent.length - 1];
    const isTabPressed = e.key === 'Tab' || e.keyCode === 9;

    if (!isTabPressed) {
      return;
    }

    if (e.shiftKey && document.activeElement === firstFocusableElement) {
      lastFocusableElement.focus();
      e.preventDefault();
    } else if (!e.shiftKey && document.activeElement === lastFocusableElement) {
      firstFocusableElement.focus();
      e.preventDefault();
    }
  };

  useEffect(() => {
    if (isOpen) {
      document.addEventListener('keydown', handleKeyDown);
    }

    return () => {
      document.removeEventListener('keydown', handleKeyDown);
    };
  }, [isOpen]);
};
