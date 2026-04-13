// @flow

declare class DOMTokenList {
  add(token: string): void;
  remove(token: string): void;
}

declare class HTMLElement {
  classList: DOMTokenList;
  value: string;
  checked: boolean;
  scrollY: number;
  input: { value: string };
  innerHTML: string;
  focus(): void;
  focus(options?: { preventScroll?: boolean, ... }): void;
  select(): void;
  scrollIntoView(): void;
  querySelector(selector: string): null | HTMLElement;
  querySelectorAll(selector: string): HTMLElement[];
  getElementsByClassName(name: string): HTMLElement[];
  getAttribute(name: string): null | string;
  hasAttribute(name: string): boolean;
  addEventListener(event: string, listener: (event: any) => mixed): void;
  removeEventListener(event: string, listener: (event: any) => mixed): void;
}

declare class HTMLBodyElement extends HTMLElement {}
declare class HTMLDivElement extends HTMLElement {}
declare class HTMLInputElement extends HTMLElement {}

declare class URL {
  constructor(url: string, base?: string): void;
  origin: string;
  pathname: string;
  search: string;
}

declare type SyntheticEvent<T = HTMLElement> = {
  currentTarget: T,
  target: T,
  preventDefault(): void,
  stopPropagation(): void,
  isPropagationStopped(): boolean,
  originalEvent?: {
    clipboardData?: {
      getData(format: string): string,
      ...
    },
    ...
  },
  clipboardData?: {
    getData(format: string): string,
    ...
  },
  ...
};

declare type SyntheticInputEvent<T = HTMLElement> = SyntheticEvent<T>;

declare type SyntheticKeyboardEvent<T = HTMLElement> = {
  ...SyntheticEvent<T>,
  key: string,
  keyCode?: number,
  shiftKey?: boolean,
};

declare var document: {
  body: HTMLBodyElement,
  activeElement: null | HTMLElement,
  documentElement?: HTMLElement,
  title: string,
  querySelector(selector: string): null | HTMLElement,
  addEventListener(event: string, listener: (event: any) => mixed): void,
  removeEventListener(event: string, listener: (event: any) => mixed): void,
  execCommand(command: string, showUI?: boolean, value?: string): boolean,
  getElementsByTagName(name: string): HTMLElement[],
  ...
};

declare var window: {
  document: typeof document,
  Pusher?: any,
  location: {
    origin: string,
    href: string,
    reload(): void,
    ...
  },
  HTMLElement: Class<HTMLElement>,
  addEventListener(event: string, listener: (event: any) => mixed): void,
  removeEventListener(event: string, listener: (event: any) => mixed): void,
  scrollTo(x: number, y: number): void,
  getComputedStyle(element: mixed): {
    display: string,
    ...
  },
  alert(message?: string): void,
  prompt(message?: string): null | string,
  ...
};
