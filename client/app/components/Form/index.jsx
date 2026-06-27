// @flow

/* eslint-disable no-unused-vars */
import React, {
  useState, useEffect, useRef, type Node,
} from 'react';
import Input from 'components/Input';
import { TYPES as INPUT_TYPES } from 'components/Input/utils';
import { QuickCreate } from 'widgets/QuickCreate';
import type { Props as QuickCreateProps } from 'widgets/QuickCreate';
import { Utils } from 'utils';
import { I18n } from 'libs/i18n';
import { useAutoSave } from 'utils/useAutoSave';
import { FeedbackBanner } from 'components/FeedbackBanner';
import css from './Form.scss';
import { getNewInputs } from './utils';
import type { Errors, MyInputProps, FormProps as Props } from './utils';

export type State = {
  inputs: MyInputProps[],
  errors: Errors,
};

const EXCLUDED_INPUT_NAMES = ['utf8', 'authenticity_token'];

const formatTimeDiff = (timestamp: number): string => {
  const diffMin = Math.floor((Date.now() - timestamp) / 60000);
  if (diffMin < 1) return I18n.t('common.autosave.time_just_now');
  if (diffMin === 1) return I18n.t('common.autosave.time_one_minute');
  if (diffMin < 60) return I18n.t('common.autosave.time_minutes_ago', { count: String(diffMin) });
  const diffHr = Math.floor(diffMin / 60);
  if (diffHr === 1) return I18n.t('common.autosave.time_one_hour');
  return I18n.t('common.autosave.time_hours_ago', { count: String(diffHr) });
};

// Reads all form input values from the DOM, keyed by `name`.
// Array-type inputs (name ends with []) collect values into arrays.
const collectFormValues = (
  form: HTMLFormElement,
): { [string]: string | string[] } => {
  const values: { [string]: string | string[] } = {};

  // Text / number / date / time / email / tel inputs and textareas
  form.querySelectorAll(
    'input[type="text"], input[type="number"], input[type="email"], '
    + 'input[type="date"], input[type="time"], input[type="tel"], textarea',
  ).forEach((el: HTMLInputElement | HTMLTextAreaElement) => {
    if (el.name && el.value !== '' && !EXCLUDED_INPUT_NAMES.includes(el.name)) {
      values[el.name] = el.value;
    }
  });

  // Hidden inputs (includes Pell textarea HTML, switch unchecked sentinels).
  // Process before checkboxes so checked state can override.
  form.querySelectorAll('input[type="hidden"]').forEach((el: HTMLInputElement) => {
    if (el.name && el.value !== '' && !EXCLUDED_INPUT_NAMES.includes(el.name)) {
      values[el.name] = el.value;
    }
  });

  // Checkboxes (switches + tag/quickCreate selections).
  // A checked checkbox overrides any previously recorded hidden sentinel.
  form.querySelectorAll('input[type="checkbox"]').forEach((el: HTMLInputElement) => {
    if (!el.name || EXCLUDED_INPUT_NAMES.includes(el.name) || !el.checked) return;
    const isArray = el.name.endsWith('[]');
    if (isArray) {
      const current = values[el.name];
      values[el.name] = Array.isArray(current)
        ? [...current, el.value]
        : [el.value];
    } else {
      values[el.name] = el.value;
    }
  });

  return values;
};

// Applies saved values back to the inputs configuration array, covering all
// input types: text/textarea, switch (checked prop), tag/quickCreate (checkboxes).
const applyRestoredValues = (
  inputs: MyInputProps[],
  values: { [string]: string | string[] },
): MyInputProps[] => inputs.map((input: MyInputProps) => {
  const saved = values[input.name] || values[`${input.name}[]`];
  if (saved === undefined) return input;

  if (input.type === 'switch') {
    const isChecked = saved === String(input.value);
    return {
      ...input, checked: isChecked, myKey: Utils.randomString(),
    };
  }

  if (input.type === 'tag' || input.type === 'quickCreate') {
    const savedIds = Array.isArray(saved) ? saved : [saved];
    const restoredCheckboxes = (input.checkboxes || []).map((cb) => ({
      ...cb,
      checked: savedIds.includes(String(cb.value)),
    }));
    return {
      ...input, checkboxes: restoredCheckboxes, myKey: Utils.randomString(),
    };
  }

  if (typeof saved === 'string' && saved !== '') {
    return {
      ...input, value: saved, myKey: Utils.randomString(),
    };
  }

  return input;
});

const getInputsInitialState = (inputs: MyInputProps[]) => inputs.filter(
  (input: MyInputProps) => typeof input.id === 'string' && input.id.length > 0,
);

export const Form = ({ action, inputs: inputsProps }: Props): Node => {
  const [inputs, setInputs] = useState<MyInputProps[]>(
    getInputsInitialState(inputsProps),
  );
  const [errors, setErrors] = useState<Errors>({});
  const [showBanner, setShowBanner] = useState<boolean>(false);
  const [bannerData, setBannerData] = useState(null);

  const myRefs: Object = {};
  const formRef = useRef<HTMLFormElement | null>(null);
  // Holds the latest collect-and-save function so the interval never captures
  // stale references across renders.
  const saveLatestRef = useRef<Function | null>(null);

  const {
    getSavedData, saveData, clearSavedData, registerSaveCallback,
  } = useAutoSave(action || '');

  // On mount: restore banner if there's a previous draft.
  useEffect(() => {
    const saved = getSavedData();
    if (saved) {
      setShowBanner(true);
      setBannerData(saved);
    }
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Assign the save function every render so the interval always reads fresh values.
  saveLatestRef.current = () => {
    if (!formRef.current) return;
    const values = collectFormValues(formRef.current);
    if (Object.keys(values).length > 0) saveData(values);
  };

  useEffect(() => {
    registerSaveCallback(() => {
      if (saveLatestRef.current) saveLatestRef.current();
    });
  }, [registerSaveCallback]);

  const handleError = (id: string, error: boolean): void => {
    const newErrors = { ...errors };
    newErrors[id] = error;
    setErrors(newErrors);
  };

  const onRestore = () => {
    if (!bannerData) return;
    setInputs(applyRestoredValues(inputs, bannerData.values));
    setShowBanner(false);
  };

  const onDismiss = () => {
    clearSavedData();
    setShowBanner(false);
    setBannerData(null);
  };

  const onSubmit = (e: SyntheticEvent<HTMLInputElement>) => {
    const { inputs: newInputs, errors: newErrors } = getNewInputs({
      inputs,
      errors,
      refs: myRefs,
    });
    const onlyErrors = Object.entries(newErrors).filter(([, value]) => value);

    if (onlyErrors.length > 0) {
      e.preventDefault();
      setInputs(newInputs);
      setErrors(newErrors);

      const labelForError = document.querySelector(
        `label[for="${onlyErrors[0][0]}"]`,
      );
      if (labelForError) {
        labelForError.scrollIntoView();
      }
    } else {
      clearSavedData();
    }
  };

  const displayInput = (input: MyInputProps): Node => (
    <div key={input.id}>
      <Input
        id={input.id}
        key={input.myKey}
        type={input.type}
        name={input.name}
        label={input.label}
        placeholder={input.placeholder}
        error={input.error}
        value={input.value}
        readOnly={input.readOnly}
        copyOnClick={input.copyOnClick}
        disabled={input.disabled}
        required={input.required}
        info={input.info}
        min={input.min}
        max={input.max}
        minLength={input.minLength}
        maxLength={input.maxLength}
        dark={input.dark}
        large={input.large}
        checked={input.checked}
        uncheckedValue={input.uncheckedValue}
        options={input.options}
        checkboxes={input.checkboxes}
        accordion={input.accordion}
        onError={input.type !== 'submit' ? handleError : undefined}
        myRef={(element) => {
          myRefs[input.id] = element;
        }}
        formNoValidate={input.type === 'submit'}
      />
    </div>
  );

  const displayQuickCreate = (input: QuickCreateProps): Node => {
    const {
      id, name, label, placeholder, checkboxes, formProps,
    } = input;
    if (!checkboxes || !name || !label) return null;
    return (
      <div key={id}>
        <QuickCreate
          id={id}
          name={name}
          label={label}
          placeholder={placeholder}
          checkboxes={checkboxes}
          formProps={formProps}
        />
      </div>
    );
  };

  const displayInputs = (): Array<Node | null> => inputs.map((input: any) => {
    if (INPUT_TYPES.includes(input.type)) {
      return displayInput(input);
    }
    if (input.type === 'quickCreate') {
      return displayQuickCreate(input);
    }
    return null;
  });

  if (!action) {
    return null;
  }

  const { form } = css;

  let csrfInput: Node = null;
  const csrfParam = document.querySelector('meta[name="csrf-param"]');
  const csrfToken = document.querySelector('meta[name="csrf-token"]');

  if (csrfParam != null && csrfToken != null) {
    csrfInput = (
      <input
        type="hidden"
        value={csrfToken.getAttribute('content')}
        name={csrfParam.getAttribute('content')}
      />
    );
  }

  const autosaveActions = [
    {
      label: I18n.t('common.autosave.restore_button'),
      onClick: onRestore,
      primary: true,
    },
    {
      label: I18n.t('common.autosave.dismiss'),
      onClick: onDismiss,
    },
  ];

  return (
    <form
      ref={formRef}
      onSubmit={onSubmit}
      acceptCharset="UTF-8"
      className={form}
      method="post"
      action={action}
    >
      {csrfInput}
      {showBanner && bannerData && (
        <FeedbackBanner
          message={I18n.t('common.autosave.restore_prompt', {
            time: formatTimeDiff(bannerData.timestamp),
          })}
          actions={autosaveActions}
        />
      )}
      {displayInputs()}
    </form>
  );
};

export default ({ action, inputs }: Props): Node => (
  <Form action={action} inputs={inputs} />
);
