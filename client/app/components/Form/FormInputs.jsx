// @flow
import React from 'react';
import { Input } from '../Input';
import { TYPES as INPUT_TYPES } from '../Input/utils';
import type { Props as InputProps } from '../Input/utils';
import { displayQuickCreate } from '../../components/Form/quickCreate';
import { Utils } from '../../utils';

type Errors = { [string]: boolean } | {};
type KeyProps = { myKey?: any };
type MyInputProps = InputProps & KeyProps;

type DisplayInputType = {
    noFormTag: boolean,
}

type InputState = {inputs: any[]};

export type Props = {
    action?: string,
    inputs: any[],
    noFormTagSubmit?: Function,
    noFormTag?: boolean, // Can't have nested forms i.e. quick create
    noFormTagRef?: any,
}

export type State = {
    inputs: any[],
    errors: Errors,
}

export const hasErrors = (errors: Errors) => Object.values(errors).filter((key) => key).length;

export class FormInputs extends React.Component<Props, State>{
    myRefs: Object;

    constructor(props: Props) {
        super(props);
        const inputs = props.inputs.filter((input: any) => input !== {});
        this.state = { inputs, errors: {} };
        this.myRefs = {};
      }


    displayInput = (input: MyInputProps) => {
    const { noFormTag } = this.props;
        return (
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
              minLength={input.minLength}
              maxLength={input.maxLength}
              dark={input.dark}
              large={input.large}
              checked={input.checked}
              uncheckedValue={input.uncheckedValue}
              options={input.options}
              checkboxes={input.checkboxes}
              accordion={input.accordion}
              onClick={
                input.type === 'submit' && noFormTag
                  ? this.handleNoFormTagSubmit
                  : undefined
              }
              onError={input.type !== 'submit' ? this.handleError : undefined}
              myRef={(element) => {
                this.myRefs[input.id] = element;
              }}
              formNoValidate={input.type === 'submit'}
            />
          </div>
        );
      };
    
      displayInputs = () : any=> {
        const { inputs } = this.state;
        console.log(inputs)
        return inputs.map((input: any) => {
          if (INPUT_TYPES.includes(input.type)) {
            return this.displayInput(input);
          }
          if (input.type === 'quickCreate') {
            return displayQuickCreate(input);
          }
          return null;
        });
      };

      render(){
          const { inputs } = this.state;
          return this.displayInputs()
      }
    
}