// @flow
import React, { useState, useRef } from 'react';
import { I18n } from 'libs/i18n';
import { InputSelect } from 'components/Input/InputSelect';
import { InputTextarea } from 'components/Input/InputTextarea';
import type { Option } from './utils';
import { Utils } from 'utils';
import globalCss from 'styles/_global.scss';

// TODO (julianguyen): Tests after writing stubs for pell editor

export type Props = {
  id: string,
  name?: string,
  value?: any,
  required?: boolean,
  hasError?: Function,
  myRef?: any,
  dark?: boolean,
  options?: Option[],
};

export const InputTextareaTemplate = ({
  id,
  name,
  value: valueProp,
  required,
  hasError,
  dark,
  options: optionsProp,
}: Props) => {
  const [value, setValue] = useState(valueProp);
  const [textareaKey, setTextareaKey] = useState();
  const textareaRef = useRef(null);

  const options = optionsProp.length > 0 && [{
    id: 'default',
    label: I18n.t('common.form.template'),
    value: '',
  }].concat(optionsProp);

  const onChangeForSelect = (e: SyntheticEvent<HTMLInputElement>) => {
    let updatedTextareaValue = '';
    if (textareaRef.current && textareaRef.current.value) {
      updatedTextareaValue = textareaRef.current.value;
      options.forEach((option) => {
        updatedTextareaValue = updatedTextareaValue.replace(option.value, '');
      });
    }
    setValue(textareaRef.current ? `${updatedTextareaValue}${e.currentTarget.value}` : e.currentTarget.value);
    setTextareaKey(Utils.randomString());
  }

  return (
    <>
      {options && !valueProp &&
        <div className={globalCss.smallMarginBottom}>
          <InputSelect
            id={`${id}-select`}
            options={options}
            dark={dark}
            onChange={onChangeForSelect}
          />
        </div>
      }
      <InputTextarea
        key={textareaKey}
        id={id}
        name={name}
        value={options ? options[0].value || value : value}
        required={required}
        hasError={hasError}
        myRef={textareaRef}
        dark={dark}
      />
    </>
  );
}
