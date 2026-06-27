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
import { useAutoSave } from 'utils/useAutoSave';
import { FormAutosaveBanner } from 'components/Form/FormAutosaveBanner';
import css from './Form.scss';
import { getNewInputs } from './utils';
import type { Errors, MyInputProps, FormProps as Props } from './utils';

export type State = {
  inputs: MyInputProps[],
  errors: Errors,
};

const getInputsInitialState = (inputs: MyInputProps[]) => inputs.filter(
  (input: MyInputProps) => typeof input.id === 'string' && input.id.length > 0,
);

export const Form = ({ action, inputs: inputsProps }: Props): Node => {
  const [inputs, setInputs] = useState<MyInputProps[]>(
    getInputsInitialState(inputsProps),
  );
  const [errors, setErrors] = useState<Errors>({});
  const [restoredAt, setRestoredAt] = useState<number | null>(null);

  const myRefs: Object = {};

  // Autosave setup – keyed by the form action URL so new vs edit are separate.
  const {
    getSavedData, saveData, clearSavedData, registerSaveCallback,
  } = useAutoSave(action || '');

  // Show restore banner when there is a saved draft from a previous session.
  const initialSaved = getSavedData();
  const [showBanner, setShowBanner] = useState<boolean>(!!initialSaved);
  const [bannerData, setBannerData] = useState(initialSaved);

  // The save function reads DOM values every interval. We hold the latest
  // version in a ref so the interval never captures stale closures.
  const saveLatestRef = useRef<Function | null>(null);
  saveLatestRef.current = () => {
    const values: { [string]: string } = {};
    Object.keys(myRefs).forEach((id) => {
      const el = myRefs[id];
      // Only save elements that carry a string value (text, textarea hidden input).
      // Switches and tag checkboxes are skipped as they have no myRef.
      if (el && typeof el.value === 'string' && el.value !== '') {
        values[id] = el.value;
      }
    });
    saveData(values);
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
    const { values, timestamp } = bannerData;
    const restoredInputs = inputs.map((input: MyInputProps) => {
      const savedValue = values[input.id];
      if (savedValue !== undefined) {
        // Changing myKey forces a re-mount of the Input child, so uncontrolled
        // inputs and the Pell rich-text editor reinitialise with the new value.
        return { ...input, value: savedValue, myKey: Utils.randomString() };
      }
      return input;
    });
    setInputs(restoredInputs);
    setRestoredAt(timestamp);
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
    const onlyErrors = Object.entries(newErrors).filter(
      ([key, value]) => value,
    );

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
      // Validation passed – form will POST and navigate away; clear the draft.
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

  return (
    <form
      onSubmit={onSubmit}
      acceptCharset="UTF-8"
      className={form}
      method="post"
      action={action}
    >
      {csrfInput}
      {showBanner && bannerData && (
        <FormAutosaveBanner
          savedAt={bannerData.timestamp}
          onRestore={onRestore}
          onDismiss={onDismiss}
        />
      )}
      {displayInputs()}
    </form>
  );
};

export default ({ action, inputs }: Props): Node => (
  <Form action={action} inputs={inputs} />
);
